//
//  RepositoriesListView.swift
//  GitSearch
//
//  Created by Erick Gonzales on 27/1/23.
//

import SwiftUI

struct RepositoriesListView: View {
    
    @StateObject var viewModel = RepositoriesListViewModel()
    @Binding var searchQuery: String
    
    var body: some View {
        List {
            ForEach(viewModel.state.repos, id: \.id) { repo in
                GitRepoViewCell(repo: repo).onAppear{
                    if viewModel.state.repos.last == repo {
                        viewModel.fetchNextPageIfPossible()
                    }
                }
            }
        }
        .onChange(of: searchQuery) { newSearch in
            viewModel.serachParam = newSearch
        }
    }
}

struct RepositoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoriesListView(searchQuery: .constant(""))
    }
}
