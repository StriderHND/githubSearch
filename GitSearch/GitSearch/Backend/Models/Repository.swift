//
//  Repository.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import Foundation

struct Repos: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    
    let id: Int
    let starsCount: Int
    let fullName: String
    let language: String?
    let updatedAt: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case language
        case description
        case fullName = "full_name"
        case updatedAt = "updated_at"
        case starsCount = "stargazers_count"
    }
}

extension Repository {
    var lastUpdate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: updatedAt)!.timeAgoDisplay()
    }
}
