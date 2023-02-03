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
    
    /** Page size of each API Request */
    private let pageSize = 10
    
    /** Initialization of the `NetworkClient` */
    private let client = NetworkClient()
    
    /** Publisher for the search query on the searchBar */
    @Published var serachParam: String = ""
    
    @Published private(set) var errorMessage: String = ""
    
    /**
    State of current API responses this tracks the current repos, page and if the user can scroll ot the next page
    */
    @Published private(set) var state = QueryState()
    
    @Published var hasError: Bool = false
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        setupBidings()
    }
}

// MARK: Combine - handlers
extension RepositoriesListViewModel {
    
    /**
    Checks if the user can navigate to the next page on the API
    */
    private func receiveCompletion(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            state.canLoadNextPage = false
        }
    }
    
    /**
    Handles the receive of current search queries batches and pagination
     
    When the user perform a serach and paginates thorugh the API  batch will update the `state` `Publisher`
    by appending the new repos of the next page also keeping track of the current page and if we can navigate to the nextPage
     
    - Parameters:
      - batch: an array of `Repository` objects
    */
    private func receive(_ batch:[Repository]) {
        state.repos += batch
        state.page += 1
        state.canLoadNextPage = batch.count == pageSize
    }
    
    /**
    Handles the receive of new search response batches
     
    When the user perform a new serach a fresh batch will update the `state` `Publisher`
     
    - Parameters:
     - batch: an array of `Repository` objects
    */
    private func receiveNewSearch(_ batch:[Repository]) {
        state.repos = batch
        state.page += 1
        state.canLoadNextPage = batch.count == pageSize
    }
    
    
    /**
      Tracks all the changes on the class publishers
    */
    private func setupBidings() {
        
        /**
         Tracks all the changes on the searchParam property comming from the search bar on the HomeView
         Here we throttle the updates for the searchParam to 1 sec this is we dont want to perform uncesarry API calls
         for each user type
         
         We also throttle the `repositoriesListPublisher`function in order to not perform unnecesarry API calls
         */
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
    
    /**
     Checks base on the `State` object and its property `canLoadNextPage` if should perform a new API request for the next page of the search
     
     This function is called when the user is at the bottom of the current page to perform a new API call to show the next elements on the next page
    */
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
    /**
     Resets the QueryState to its default value
     
     This function is used to reset the QueryState of a current search in case a new search query is perform
     
    */
    private func clearState() {
        state = QueryState()
    }
    
    /**
     Takes a query and a page indicator to create a URLRequest for thte GitHub API.
     
     This function creates a URLRequest based on the query and page track on the GitHub API respose.
     if the query string is empty it will handle to a defaut value of "Q"
     
     - Returns:
     An URLRequest base on query a current page
     
     - Parameters:
        - query: the search term
        - page: current page location
     */
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
    
    /**
     Creates publisher from the API request
     
     This function creates a Future publisher with the response of the API with an array of `Repository`
     
     - Returns:
     An `Futute<[Repository, Error]>` publisher object
     
     - Parameters:
        - query: the search term
        - page: current page location
     */
    private func repositoriesListPublisher(forQuery query:String?, page: Int) -> Future<[Repository], Error> {
        Future {
            let request = self.buildRequest(with: query, page: page)
            let response = try await self.client.putRequest(type: Repos.self, with: request)
            return response.items.compactMap{ $0 }
        }
    }
}
