//
//  RepositoryTests.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import XCTest
@testable import GitSearch

class RepositoryTests: XCTestCase {
    
    func testRepositoryDecoding() {
        let jsonData = """
        {
            "id": 12345,
            "full_name": "TestRepo",
            "stargazers_count": 1000,
            "language": "Swift",
            "updated_at": "2022-01-01T12:00:00Z",
            "description": "A test repository for testing purposes"
        }
        """.data(using: .utf8)!
        
        do {
            let decodedRepository = try JSONDecoder().decode(Repository.self, from: jsonData)
            
            XCTAssertEqual(decodedRepository.id, 12345)
            XCTAssertEqual(decodedRepository.fullName, "TestRepo")
            XCTAssertEqual(decodedRepository.starsCount, 1000)
            XCTAssertEqual(decodedRepository.language, "Swift")
            XCTAssertEqual(decodedRepository.updatedAt, "2022-01-01T12:00:00Z")
            XCTAssertEqual(decodedRepository.description, "A test repository for testing purposes")
        } catch {
            XCTFail("Failed to decode repository: \(error)")
        }
    }
    
    func testLastUpdate() {
        let repo = Repository(id: 12345,
                              starsCount: 1000,
                              fullName: "TestRepo",
                              language: "Swift",
                              updatedAt: "2022-01-01T12:00:00Z",
                              description: "A test repository for testing purposes")
        
        let lastUpdate = repo.lastUpdate
        
        XCTAssert(lastUpdate.contains("ago"), "Expected 'lastUpdate' to contain the word 'ago'")
    }
    
    func testRepositoryEquality() {
        let repo1 = Repository(id: 12345,
                               starsCount: 1000,
                               fullName: "TestRepo",
                               language: "Swift",
                               updatedAt: "2022-01-01T12:00:00Z",
                               description: "A test repository for testing purposes")
        
        let repo2 = Repository(id: 12345,
                               starsCount: 1000,
                               fullName: "TestRepo",
                               language: "Swift",
                               updatedAt: "2022-01-01T12:00:00Z",
                               description: "A test repository for testing purposes")
        
        XCTAssertEqual(repo1, repo2)
    }
}

