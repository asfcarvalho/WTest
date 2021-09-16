//
//  ArticleViewModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

enum ArticleType {
    case image
    case title
    case body
}

struct ArticleViewModel {
    let title: String?
    let author: String?
    let summary: String?
    let body: String?
    var publishedAt: String?
    let hero: String?
    let avatar: String?
    
    var types: [ArticleType] = []
    
    init(_ article: ArticleListViewModel.ArticleViewModel?) {
        self.title = article?.title
        self.author = article?.author
        self.summary = article?.summary
        self.body = article?.body
        self.publishedAt = article?.publishedAt
        self.hero = article?.hero
        self.avatar = article?.avatar
        
        types = [.title, .body]
    }
}
