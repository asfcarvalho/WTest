//
//  Article.swift
//  WTestArticle
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import Foundation

struct ArticleElement: Codable {
    let id, title, publishedAt: String?
    let hero: String?
    let author: String?
    let avatar: String?
    let summary, body: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case publishedAt = "published-at"
        case hero, author, avatar, summary, body
    }
}

typealias Article = [ArticleElement]
