//
//  NetworkServiceTests.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import XCTest
@testable import GitSearch

class NetworkServiceTests: XCTestCase {

    var networkService: NetworkService!
    var urlSessionMock: URLSessionMock!
    var data: Data!
    var error: Error!
    var response: HTTPURLResponse!

    override func setUp() {
        super.setUp()
        data = try! JSONEncoder().encode(Repos(items: [Repository(id: 12345,
                                                                  starsCount: 1000,
                                                                  fullName: "TestRepo",
                                                                  language: "Swift",
                                                                  updatedAt: "2022-01-01T12:00:00Z",
                                                                  description: "A test repository for testing purposes")]))
        error = NSError(domain: "error", code: 1234, userInfo: nil)
        response = HTTPURLResponse(url: URL(string: "https://api.github.com/search/repositories?q=Swift")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        urlSessionMock = URLSessionMock()
        urlSessionMock.data = data
        urlSessionMock.error = error
        urlSessionMock.response = response
        
    }

    func testPutRequestSuccess() async {
        urlSessionMock.error = nil
        networkService = NetworkServiceMock(session: urlSessionMock)
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=Swift")!)
        
        do {
            let repos = try await networkService.putRequest(type: Repos.self, with: request)
            XCTAssertEqual(repos.items.first?.id, 12345)
            XCTAssertEqual(repos.items.first?.fullName, "TestRepo")
        } catch {
            print(String(describing: error))
            XCTFail("Test Put Request failed with error: \(error)")
        }
    }
    
    func testPutRequestFailed() async {
        let request = URLRequest(url: URL(string: "https://api.github.com/search/repositories?q=Swift")!)
        urlSessionMock.error = APIError.requestFailed(description: "Invalid Response")
        networkService = NetworkServiceMock(session: urlSessionMock)
        do {
            _ = try await networkService.putRequest(type: Repos.self, with: request)
            XCTFail("Test Put Request succeeded, expected error")
        } catch let error as APIError {
            print(String(describing: error))
            XCTAssertEqual(error.customDescription, "Request Failed: Invalid Response")
        } catch {
            XCTFail("Test Put Request failed with unexpected error: \(error)")
        }
    }
}


