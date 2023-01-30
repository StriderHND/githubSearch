//
//  RepositoriesListViewModel.swift
//  GitSearch
//
//  Created by Erick Gonzales on 27/1/23.
//

import Foundation

@MainActor
final class RepositoriesListViewModel: ObservableObject {
    
    private let client = NetworkClient()
    @Published private(set) var repos: [Repository] = []
    @Published private(set) var errorMessage: String = ""
    @Published var hasError: Bool = false
    
    
    func fetchRepos(with param:String?) async {
        
        let request = buildRequest(with: param)
        
        do{
            let response = try await client.putRequest(type: Repos.self, with: request)
            repos = response.items.compactMap{ $0 }
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
            hasError = true
        }
    }
    
    func buildRequest(with param:String?) -> URLRequest {
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
    
    func runSearch(with param:String?) {
        Task {
            await self.fetchRepos(with: param)
        }
    }
}
