//
//  RepositoriesListViewModel.swift
//  GitSearch
//
//  Created by Erick Gonzales on 27/1/23.
//

import Foundation
import Combine

@MainActor
final class RepositoriesListViewModel: ObservableObject {
    
    private let client = NetworkClient()
    @Published var serachParam: String = ""
    @Published private(set) var repos: [Repository] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        setupBidings()
    }
}


// MARK: - Private Methods
extension RepositoriesListViewModel {
    
    private func buildRequest(with param:String?) -> URLRequest {
        var searchQuery:String = ""
        
        if let unwrappedParam = param {
            if unwrappedParam.isEmpty{
                searchQuery = "Q"
            } else {
                searchQuery = unwrappedParam
            }
        }
       
        let urlString = "https://api.github.com/search/repositories?q=\(searchQuery)"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    private func repositoriesListPublisher(forParam param:String?) -> Future<[Repository], Error> {
        Future {
            let request = self.buildRequest(with: param)
            let response = try await self.client.putRequest(type: Repos.self, with: request)
            return response.items.compactMap{ $0 }
        }
    }
    
    private func setupBidings() {
        self.$serachParam.sink { value in
            self.repositoriesListPublisher(forParam: value)
                .receive(on: DispatchQueue.main)
                .sink { error in
                    print(error)
                } receiveValue: { response in
                    self.repos = response
                }
                .store(in: &self.subscriptions)
        }
        .store(in: &self.subscriptions)
    }
}
