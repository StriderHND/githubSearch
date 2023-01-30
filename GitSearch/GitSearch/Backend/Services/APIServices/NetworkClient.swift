//
//  NetworkClient.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import Foundation

final class NetworkClient: NetworkService {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}
