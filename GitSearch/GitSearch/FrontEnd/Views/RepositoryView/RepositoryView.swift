//
//  RepositoryView.swift
//  GitSearch
//
//  Created by Erick Gonzales on 4/2/23.
//

import SwiftUI

struct RepositoryView: View {
    @StateObject var viewModel: RepositoryViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(viewModel:RepositoryViewModel(repository:Repository(
            id: 345346,
            starsCount: 10,
            fullName: "apple/swift",
            language: "C++",
            updatedAt: "2023-01-30T11:33:29Z",
            description: "The Swift Programming Language."
        )))
    }
}
