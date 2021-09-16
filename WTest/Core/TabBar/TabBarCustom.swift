//
//  TabBarCustom.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import UIKit

class TabBarCustom: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.gray
        
        loadScreens()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadScreens()
    }
    
    @objc func loadScreens() {
        self.selectedIndex = 0
        
        let articles = UINavigationController(rootViewController: ArticleListViewController())
        articles.title = "Artigos"
        articles.tabBarItem.image = UIImage(systemName: "newspaper.fill")
        
        let forms = UINavigationController(rootViewController: FormsViewController())
        forms.title = "Forms"
        forms.tabBarItem.image = UIImage(systemName: "note.text.badge.plus")
        
        self.viewControllers = [articles, forms]
    }
}
