//
//  NetworkService.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import Foundation

enum ApiError: Error {
    case noInternet
    case invalidData
    case jsonParsingFailure
    case failedSerialization
    case requestFailed(description: String)
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    
    var customDescription: String {
        switch self {
        case .invalidData: return "Invalid Data)"
        case .noInternet: return "No internet connection"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case let .requestFailed(description): return "Request Failed: \(description)"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        }
    }
}


protocol NetworkService {
    var session: URLSession { get }
    func putRequest<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T
}

extension NetworkService {
    func putRequest<T: Codable>(type: T.Type, with request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else  {
            throw ApiError.requestFailed(description: "Invalid Response")
        }
        
        guard httpResponse.statusCode == 200 else {
            throw ApiError.responseUnsuccessful(description: "Status Code: \(httpResponse.statusCode)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            throw ApiError.jsonConversionFailure(description: error.localizedDescription)
        }
    }
}
