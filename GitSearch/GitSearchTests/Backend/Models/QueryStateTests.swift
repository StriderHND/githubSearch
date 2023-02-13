//
//  QueryStateTests.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import XCTest
@testable import GitSearch

class QueryStateTests: XCTestCase {
    
    func testInitialization() {
        let queryState = QueryState()
        XCTAssertEqual(queryState.repos, [])
        XCTAssertEqual(queryState.page, 1)
        XCTAssertEqual(queryState.canLoadNextPage, true)
    }
    
    func testRepos() {
        var queryState = QueryState()
        let repo1 = Repository(id: 0976, starsCount: 10, fullName: "Repo 1", language: "Swift", updatedAt: "2023-02-13T17:11:00-0600", description: "Description 1")
        let repo2 = Repository(id: 9658, starsCount: 20, fullName: "Repo 2", language: "Objective-C", updatedAt: "2023-02-13T17:11:00-0600", description: "Description 2")
        queryState.repos = [repo1, repo2]
        
        XCTAssertEqual(queryState.repos[0].fullName, "Repo 1")
        XCTAssertEqual(queryState.repos[0].description, "Description 1")
        XCTAssertEqual(queryState.repos[0].updatedAt, "2023-02-13T17:11:00-0600")
        XCTAssertEqual(queryState.repos[0].starsCount, 10)
        XCTAssertEqual(queryState.repos[0].language, "Swift")
        
        XCTAssertEqual(queryState.repos[1].fullName, "Repo 2")
        XCTAssertEqual(queryState.repos[1].description, "Description 2")
        XCTAssertEqual(queryState.repos[1].updatedAt,  "2023-02-13T17:11:00-0600")
        XCTAssertEqual(queryState.repos[1].starsCount, 20)
        XCTAssertEqual(queryState.repos[1].language, "Objective-C")
    }
    
    func testPage() {
        var queryState = QueryState()
        queryState.page = 2
        XCTAssertEqual(queryState.page, 2)
    }
    
    func testCanLoadNextPage() {
        var queryState = QueryState()
        queryState.canLoadNextPage = false
        XCTAssertEqual(queryState.canLoadNextPage, false)
    }
}
