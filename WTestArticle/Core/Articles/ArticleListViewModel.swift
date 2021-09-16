//
//  ArticleListViewModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class NewArticleListViewModel {
    
    var articleList: [NewArticleViewModel]?
    
    private var pageLimit = 20
    private var pageIndex = 1
    private var totalPage = 1
    
    struct NewArticleViewModel {
        let title: String
        let author: String
        let summary: String
        let body: String?
        let publishedAt: String?
        let hero: String?
        let avatar: String?
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
    
    private func articleParse(_ article: NewArticle) {
        self.totalPage = Int((Double(article.count) / Double(pageLimit)).rounded(.up))
        
        let articleListTemp = article.map({
            NewArticleViewModel(title: $0.title ?? "",
                             author: $0.author ?? "",
                             summary: $0.summary ?? "",
                             body: $0.body,
                             publishedAt: formatDateTime($0.publishedAt),
                             hero: $0.hero,
                             avatar: $0.avatar)
        })
        
        if self.articleList == nil {
            self.articleList = articleListTemp
        } else {
            articleList?.append(contentsOf: articleListTemp)
        }
    }
    
    func shouldCallNextPage(_ indexPaths: [IndexPath]) -> Bool {
        if pageIndex <= totalPage,
           isEndOfFile(indexPaths) {
            pageIndex += 1
            return true
        }
        
        return false
    }
    
    private func isEndOfFile(_ indexPaths: [IndexPath]) -> Bool {
        guard let count = articleList?.count, count > 0 else {
            return false
        }
        return indexPaths.map({ $0.row }).contains(count - 1)
    }
    
    private func formatDateTime(_ publishedAt: String?) -> String {
        let date = publishedAt?.toLogDate()
        return date?.toShortDateString() ?? ""
    }
}
