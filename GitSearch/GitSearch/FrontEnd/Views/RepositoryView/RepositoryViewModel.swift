//
//  RepositoryViewModel.swift
//  GitSearch
//
//  Created by Erick Gonzales on 4/2/23.
//

import Foundation
import Combine

final class RepositoryViewModel: ObservableObject{
    private(set) var repository:Repository
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init(repository: Repository) {
        self.repository = repository
    }
}


//MARK: - Public methods
extension RepositoryViewModel {
    
    func getRepoName() -> String {
        return repository.fullName
    }
    
    func getRepoDescription() -> String {
        return repository.description
    }
    
    func getLastUpdate() -> String {
        return repository.lastUpdate
    }
    
    func getStarsCount() -> String {
        return "Stars: \(repository.starsCount.description) ⭐️"
    }
    
    func getLanguage() -> String {
        return repository.language ?? "N/A"
    }
}
