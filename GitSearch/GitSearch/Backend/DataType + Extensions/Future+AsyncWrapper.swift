//
//  Future+AsyncWrapper.swift
//  GitSearch
//
//  Created by Erick Gonzales on 31/1/23.
//

import Foundation
import Combine

extension Future where Failure == Error {
    convenience init(operation: @escaping() async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let output = try await operation()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
