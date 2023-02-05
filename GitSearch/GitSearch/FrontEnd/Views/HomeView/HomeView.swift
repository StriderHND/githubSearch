//
//  ContentView.swift
//  GitSearch
//
//  Created by Erick Gonzales on 26/1/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var searchQuery = ""
    
    var body: some View {
        NavigationStack{
            RepositoriesListView(searchQuery: $searchQuery)
                .navigationTitle("Repositories")
        }
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(text: $searchQuery, prompt: "Search repository")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
