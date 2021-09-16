//
//  ArticleModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let items: [Item]?
    let count: Int?
}

// MARK: - Item
struct Item: Codable {
    let id, title, publishedAt: String?
    let hero, String?
    let author, summary, body, limit: String?
    let page: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case publishedAt = "published-at"
        case hero, author, summary, body, limit, page
    }
}

