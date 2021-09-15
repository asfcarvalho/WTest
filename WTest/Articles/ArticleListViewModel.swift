//
//  ArticleListViewModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

class ArticleListViewModel {
    
    var articleList: [ArticleViewModel] = []
    
    private var pageLimit = 10
    private var pageIndex = 1
    private var totalPage = 1
    
    struct ArticleViewModel {
        let title: String
        let author: String
        let summary: String
    }
    
    func fetchData(competion: @escaping () -> Void) {
        ArticleListInteractor.fetchData(with: pageIndex, pageLimit: pageLimit) { result in
            switch result {
            case .success(let article):
                self.articleParse(article)
            case .failure(let error):
                print(error)
            }
            
            competion()
        }
    }
    
    private func articleParse(_ article: Article) {
        self.totalPage = Int(article.count ?? 1 / self.pageLimit)
        self.articleList = article.items?.map({
            ArticleViewModel(title: $0.title ?? "", author: $0.author ?? "", summary: $0.summary ?? "")
        }) ?? []
    }
}
