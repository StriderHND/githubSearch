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
    private let pageSize = 10
    private let client = NetworkClient()
    @Published var serachParam: String = ""
    @Published private(set) var errorMessage: String = ""
    @Published private(set) var state = State()
    @Published var hasError: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        setupBidings()
    }
}

// MARK: Combine - handlers
extension RepositoriesListViewModel {
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }
    
    private func receive(_ batch:[Repository]) {
        state.repos += batch
        state.page += 1
        state.canLoadNextPage = batch.count == pageSize
    }
    
    private func receiveNewSearch(_ batch:[Repository]) {
        state.repos = batch
        state.page += 1
        state.canLoadNextPage = batch.count == pageSize
    }
    
    private func setupBidings() {
        self.$serachParam
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .sink { query in
                self.clearState()
                self.repositoriesListPublisher(forQuery: query, page: self.state.page)
                    .receive(on: DispatchQueue.main)
                    .throttle(for: 1.0, scheduler: DispatchQueue.main, latest: true)
                    .sink(receiveCompletion: { completion in
                        self.receiveCompletion(completion)
                    }, receiveValue: { batch in
                        self.receiveNewSearch(batch)
                    })
                    .store(in: &self.subscriptions)
            }
            .store(in: &self.subscriptions)
    }
}

// MARK: Public Methods
extension RepositoriesListViewModel {
    func fetchNextPageIfPossible() {
        guard state.canLoadNextPage else {
            return
        }
        
        repositoriesListPublisher(forQuery: serachParam, page: state.page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.receiveCompletion(completion)
            }, receiveValue: { batch in
                self.receive(batch)
            })
            .store(in: &self.subscriptions)
    }
}


// MARK: - Private Methods
extension RepositoriesListViewModel {
    
    private func clearState() {
        state = State()
    }
    
    private func buildRequest(with query:String?, page:Int) -> URLRequest {
        var searchQuery:String = ""
        
        if let unwrappedQuery = query {
            if unwrappedQuery.isEmpty{
                searchQuery = "Q"
            } else {
                searchQuery = unwrappedQuery
            }
        }
        
        let urlString = "https://api.github.com/search/repositories?q=\(searchQuery)&per_page=\(pageSize)&page=\(page)"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }
    
    private func repositoriesListPublisher(forQuery query:String?, page: Int) -> Future<[Repository], Error> {
        Future {
            let request = self.buildRequest(with: query, page: page)
            let response = try await self.client.putRequest(type: Repos.self, with: request)
            return response.items.compactMap{ $0 }
        }
    }
}

extension RepositoriesListViewModel {
    struct State {
        var repos: [Repository] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
}
