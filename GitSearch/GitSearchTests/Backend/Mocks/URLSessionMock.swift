//
//  URLSessionMock.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var response: URLResponse?

    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = self.response

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }

    private class URLSessionDataTaskMock: URLSessionDataTask {
        private let closure: () -> Void

        init(_ closure: @escaping () -> Void) {
            self.closure = closure
        }

        override func resume() {
            closure()
        }
    }
}
