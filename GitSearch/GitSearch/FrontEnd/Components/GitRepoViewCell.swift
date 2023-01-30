//
//  GitRepoViewCell.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import SwiftUI

struct GitRepoViewCell: View {
    
    @State var starsCount: Int
    @State var updatedAt: Date
    @State var languate: String
    @State var description: String
    @State var fullRepoName: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct GitRepoViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GitRepoViewCell(starsCount: <#Int#>,
                        updatedAt: <#Date#>,
                        languate: <#String#>,
                        description: <#String#>,
                        fullRepoName: <#String#>)
    }
}
