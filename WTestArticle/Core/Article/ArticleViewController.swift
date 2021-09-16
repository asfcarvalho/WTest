//
//  ArticleViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

class ArticleViewController: UIViewController {
    
    private var viewModel: NewArticleViewModel?
    private var headerView: ArticleImageCell?
    private var minImageHeight: CGFloat = 150
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: NewArticleViewModel?) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = viewModel?.title
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()

        tableView.contentInset = UIEdgeInsets(top: minImageHeight + tableView.safeAreaInsets.top,
                                              left: 0,
                                              bottom: 0,
                                              right: 0)
        headerView?.updatePosition()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        headerView?.updatePosition()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView?.updatePosition()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        setHeaderViewInTableView()
        setTableViewInView()
    }
    
    private func setTableViewInView() {
        tableView.register(ArticleTitleCell.self, forCellReuseIdentifier: ArticleTitleCell.identifier)
        tableView.register(ArticleBodyCell.self, forCellReuseIdentifier: ArticleBodyCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundView = UIView()
        tableView.backgroundView?.addSubview(headerView ?? UIView())
        tableView.contentInset = UIEdgeInsets(
            top: minImageHeight,
            left: 0,
            bottom: 0,
            right: 0)
        
        view.addSubviews([tableView])
        
        tableView.edgeToSuperView()
    }
    
    private func setHeaderViewInTableView() {
        headerView = ArticleImageCell(frame: CGRect(
                                        x: 0,
                                        y: tableView.safeAreaInsets.top,
                                        width: view.frame.width,
                                        height: minImageHeight))
        headerView?.awakeFromNib()
        headerView?.autoresizingMask = .flexibleHeight
        headerView?.scrollView = tableView
        headerView?.loadData(viewModel?.hero)
    }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.types.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel?.types[indexPath.row] {
//        case .image:
//            headerView?.loadData(viewModel?.hero)
//////            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleImageCell.identifier, for: indexPath) as? ArticleImageCell else {
//                return UITableViewCell()
//////            }
//////
//////            cell.awakeFromNib()
//////            cell.loadData(viewModel?.hero)
//////
//////            return cell
//        break
        case .title:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTitleCell.identifier, for: indexPath) as? ArticleTitleCell else {
                return UITableViewCell()
            }
            
            cell.awakeFromNib()
            cell.loadData(viewModel)
            
            return cell
        case .body:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleBodyCell.identifier, for: indexPath) as? ArticleBodyCell else {
                return UITableViewCell()
            }
            
            cell.awakeFromNib()
            cell.loadData(viewModel?.body)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}
