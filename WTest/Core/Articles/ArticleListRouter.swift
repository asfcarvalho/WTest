//
//  ArticleListRouter.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleListRouter {
    
    func openArticle(from viewController: UIViewController, articleViewModel: ArticleViewModel) {
        let articleView = ArticleViewController(viewModel: articleViewModel)
        viewController.navigationController?.pushViewController(articleView, animated: true)
    }
}
