//
//  ContentView.swift
//  GitSearch
//
//  Created by Erick Gonzales on 26/1/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchQuery = ""
    
    var body: some View {
        NavigationView{
            RepositoriesListView(searchQuery: $searchQuery)
        }
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(text: $searchQuery, prompt: "Search repository")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
