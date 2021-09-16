//
//  ArticleListViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    private var viewModel: NewArticleListViewModel?
    private var router: ArticleListRouter?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.bounces = false
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = NewArticleListViewModel()
        router = ArticleListRouter()
        configUI()
        fetchData()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: ArticleListCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        
        view.addSubviews([tableView])
        
        tableView.edgeToSuperView()
    }
    
    private func fetchData(animation: Bool = true) {
        if animation {
            Loading.shared.showLoading(view)
        }
        viewModel?.fetchData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            Loading.shared.stopLoading()
        }
    }
    
    private func openArticle(_ index: Int) {
        let articleViewModel = NewArticleViewModel(viewModel?.articleList?[index])
        router?.openArticle(from: self, articleViewModel: articleViewModel)
    }
}

extension ArticleListViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.articleList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListCell.identifier) as? ArticleListCell else {
            return UITableViewCell()
        }
        
        let article = viewModel?.articleList?[indexPath.row]
        
        cell.awakeFromNib()
        cell.loadData(with: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if viewModel?.shouldCallNextPage(indexPaths) == true {
            fetchData(animation: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        openArticle(indexPath.row)
    }
}
