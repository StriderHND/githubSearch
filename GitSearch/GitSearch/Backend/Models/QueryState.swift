//
//  State.swift
//  GitSearch
//
//  Created by Erick Gonzales on 3/2/23.
//

import Foundation

struct QueryState {
    var repos: [Repository] = []
    var page: Int = 1
    var canLoadNextPage = true
}
