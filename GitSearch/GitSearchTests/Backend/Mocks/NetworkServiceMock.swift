//
//  NetworkServiceMock.swift
//  GitSearchTests
//
//  Created by Erick Gonzales on 13/2/23.
//

import Foundation
@testable import GitSearch

class NetworkServiceMock: NetworkService {
    var session: URLSession
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    init(session: URLSessionMock) {
        self.session = session
        self.data = session.data
        self.error = session.error
        self.response = session.response
    }
    
    func putRequest<T>(type: T.Type, with request: URLRequest) throws -> T where T : Decodable, T : Encodable {
        let httpResponse = response as? HTTPURLResponse
        if let httpResponse = httpResponse, (405..<500 ~= httpResponse.statusCode) {
            throw APIError.responseUnsuccessful(description: "Client error - Status Code: \(httpResponse.statusCode)")
        }
        if let httpResponse = httpResponse, (500..<600 ~= httpResponse.statusCode) {
            throw APIError.responseUnsuccessful(description: "Server error - Status Code: \(httpResponse.statusCode)")
        }
        if let error = error {
            throw error
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data ?? Data())
        } catch {
            throw APIError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}
