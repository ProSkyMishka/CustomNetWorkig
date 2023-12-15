//
//  ArticlesModel.swift
//  customNetworking
//
//  Created by Михаил Прозорский on 15.12.2023.
//

import Foundation

struct Welcome: Codable {
    let news: [News]
}

struct News: Codable {
    let newsID, storyID, score: Int
    let date, title, announce, sectionName: String

    enum CodingKeys: String, CodingKey {
        case newsID = "newsId"
        case storyID = "storyId"
        case score, date, title, announce, sectionName
    }
}
