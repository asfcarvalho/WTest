//
//  ArticleListInteractor.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

class ArticleListInteractor {
    
    let apiCalling = APICalling()
    
    static func fetchData(with page: Int, pageLimit: Int, callBack: @escaping (Result<Article, Error>) -> Void) {
        let apiRequest = APIRequest()
        let urlString = String(format: "\(AppConfig.shared.baseURL)?page=%i&limit=%i", page, pageLimit)
        apiRequest.baseURL = URL(string: urlString)
        
        APICalling().fetch(apiRequest: apiRequest, callBack: callBack)
    }
}
