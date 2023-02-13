//
//  RepositoriesListViewModelTests.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import XCTest
import Combine

@testable import GitSearch

@MainActor
final class RepositoriesListViewModelTests: XCTestCase {
    
    private var viewModel: RepositoriesListViewModel!
    private var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        viewModel = RepositoriesListViewModel()
    }
    
    func testSerachParamThrottle() {
        let expectation = XCTestExpectation(description: "Serach param throttle")
        let expectedSerachParam = ""
        viewModel.$serachParam
            .sink { searchParam in
                XCTAssertEqual(searchParam, expectedSerachParam)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        viewModel.serachParam = expectedSerachParam
        wait(for: [expectation], timeout: 2)
    }
    
    func testErrorMessage() {
        let expectation = XCTestExpectation(description: "Error message")
        let expectedErrorMessage = ""
        viewModel.$errorMessage
            .sink { errorMessage in
                XCTAssertEqual(errorMessage, expectedErrorMessage)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2)
    }
    
    func testHasError() {
        let expectation = XCTestExpectation(description: "Has error")
        viewModel.$hasError
            .sink { hasError in
                XCTAssertFalse(hasError)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        viewModel.hasError = false
        wait(for: [expectation], timeout: 2)
    }
    
    func testFetchNextPageIfPossible() {
        let expectation = XCTestExpectation(description: "Fetch next page")
        viewModel.fetchNextPageIfPossible()
        viewModel.$state
            .sink { state in
                XCTAssertEqual(state.page, 1)
                expectation.fulfill()
            }
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2)
    }
}

