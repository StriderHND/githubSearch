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
    
    var request: URLRequest = {
        let urlString = "https://api.github.com/search/repositories?q=Q"
        let url = URL(string: urlString)!
        return URLRequest(url: url)
    }()
    
    func fetchRepos() async {
        do{
            let response = try await client.putRequest(type: Repos.self, with: request)
            repos = response.items.compactMap{ $0 }
        } catch {
            errorMessage = "\((error as! ApiError).customDescription)"
            hasError = true
        }
    }
}
