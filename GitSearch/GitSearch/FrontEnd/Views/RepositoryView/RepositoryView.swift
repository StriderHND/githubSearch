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
        VStack(alignment: .leading){
            Text(viewModel.getLastUpdate())
            Text(viewModel.getRepoDescription())
                .lineLimit(3)
                .font(.body)
            Text(viewModel.getLanguage())
            Text(viewModel.getStarsCount())
        }
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
