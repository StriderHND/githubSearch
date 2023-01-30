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
    @State var language: String
    @State var description: String
    @State var fullRepoName: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.cyan)
                .opacity(0.9)
                .frame(height: 150)
            
            VStack(alignment: .leading, spacing: 5){
                Text(fullRepoName)
                    .font(.title)
                    .bold()
                Text(description)
                Text(language)
                    .font(.caption)
                Text("Stars: \(starsCount.description)" )
                    .font(.caption2)
                Text("Updated: \(updatedAt.timeAgoDisplay())")
                    .font(.caption2)
            }.foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct GitRepoViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GitRepoViewCell(starsCount: 10,
                        updatedAt: Date(timeInterval: -60000, since: .now),
                        language: "C++",
                        description: "The Swift Programming Language.",
                        fullRepoName: "apple/swift")
    }
}
