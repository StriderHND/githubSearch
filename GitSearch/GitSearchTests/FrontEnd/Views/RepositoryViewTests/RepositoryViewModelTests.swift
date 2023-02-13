//
//  RepositoryViewModelTests.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import XCTest
@testable import GitSearch

class RepositoryViewModelTests: XCTestCase {
    private var repositoryViewModel: RepositoryViewModel!
    
    override func setUp() {
        super.setUp()
        let repository = Repository(id: 0865,
                                    starsCount: 100,
                                    fullName: "Test Repo",
                                    language: "Swift",
                                    updatedAt: "2023-02-13T17:11:00-0600",
                                    description: "Test Description")
        repositoryViewModel = RepositoryViewModel(repository: repository)
    }
    
    func testGetRepoName() {
        XCTAssertEqual(repositoryViewModel.getRepoName(), "Test Repo")
    }
    
    func testGetRepoDescription() {
        XCTAssertEqual(repositoryViewModel.getRepoDescription(), "Test Description")
    }
    
    func testGetLastUpdate() {
        XCTAssertEqual(repositoryViewModel.getLastUpdate(), "in 5 hours")
    }
    
    func testGetStarsCount() {
        XCTAssertEqual(repositoryViewModel.getStarsCount(), "Stars: 100 ⭐️")
    }
    
    func testGetLanguage() {
        XCTAssertEqual(repositoryViewModel.getLanguage(), "Swift")
    }
}
