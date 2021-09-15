//
//  ArticleListViewModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

class ArticleListViewModel {
    
    var articleList: [ArticleViewModel]?
    
    private var pageLimit = 20
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
        self.totalPage = Int((Double(article.count!) / Double(pageLimit)).rounded(.up))
        
        let articleListTemp = article.items?.map({
            ArticleViewModel(title: $0.title ?? "", author: $0.author ?? "", summary: $0.summary ?? "")
        }) ?? []
        
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
}
