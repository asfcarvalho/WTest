//
//  ArticleListViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleListViewController: UIViewController {
    
    private let cellName = "cell"
    private var viewModel: ArticleListViewModel?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.bounces = false
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configUI()
        fetchData()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        
        view.addSubviews([tableView])
        
        tableView.edgeToSuperView()
    }
    
    private func fetchData() {
        viewModel = ArticleListViewModel()
        Loading.shared.showLoading(view)
        viewModel?.fetchData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            Loading.shared.stopLoading()
        }
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.articleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) else {
            return UITableViewCell()
        }
        
        let article = viewModel?.articleList[indexPath.row]
        
        cell.textLabel?.text = article?.title
        
        return cell
    }
}
