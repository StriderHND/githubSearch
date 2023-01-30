//
//  Repository.swift
//  GitSearch
//
//  Created by Erick Gonzales on 30/1/23.
//

import Foundation

struct Repos: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
    
    let id: Int
    let updatedAt: Date?
    let starsCount: Int?
    let fullName: String?
    let language: String?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case language
        case description
        case fullname = "full_name"
        case updatedAt = "updated_at"
        case starsCount = "stargazers_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        fullName = try container.decode(String.self, forKey: .fullname)
        updatedAt = try container.decode(Date.self, forKey: .updatedAt)
        language = try container.decode(String.self, forKey: .language)
        starsCount = try container.decode(Int.self, forKey: .starsCount)
        description = try container.decode(String.self, forKey: .description)
    }
}
