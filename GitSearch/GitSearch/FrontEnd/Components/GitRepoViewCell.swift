//
//  GitRepoViewCell.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import SwiftUI

struct GitRepoViewCell: View {
    
    var repo: Repository
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .fill(.cyan)
                .opacity(0.9)
                .frame(height: 250)
            
            VStack(alignment: .leading, spacing: 5){
                Text(repo.fullName)
                    .font(.title)
                    .bold()
                Text(repo.description)
                Text(repo.language ?? "N/A")
                    .font(.caption)
                Text("Stars: \(repo.starsCount.description)" )
                    .font(.caption2)
                Text("Updated: \(repo.lastUpdate)")
                    .font(.caption2)
            }.foregroundColor(.white)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct GitRepoViewCell_Previews: PreviewProvider {
    static var previews: some View {
        GitRepoViewCell(repo: Repository(
            id: 345346,
            starsCount: 10,
            fullName: "apple/swift",
            language: "C++",
            updatedAt: "2023-01-30T11:33:29Z",
            description: "The Swift Programming Language."
        ))
    }
}
