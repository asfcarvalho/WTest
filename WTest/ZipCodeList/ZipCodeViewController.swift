//
//  ZipCodeViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 14/09/21.
//

import UIKit

class ZipCodeViewController: UIViewController {
    
    private let cellName = "cell"
    private var isSeraching = false
    
    var viewModel: ZipCodeListViewModel?
    
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.bounces = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        configUI()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
        notificationCenter.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
    }
    
    private func handleKeyboard(notification: Notification) {
      // 1
      guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
        tableView.bottomToSuperview()
        view.layoutIfNeeded()
        return
      }

      guard
        let info = notification.userInfo,
        let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
          return
      }

      // 2
      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      UIView.animate(withDuration: 0.1, animations: { () -> Void in
        self.tableView.bottomToSuperview(margin: keyboardHeight)
        //self.searchFooterBottomConstraint.constant = keyboardHeight
        self.view.layoutIfNeeded()
      })
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        tableView.register(ZipCodeCell.self, forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        
        view.addSubviews([searchBar, tableView])
        
        searchBar
            .topToSuperview()
            .edgeToSuperViewHorizontal()
        
        tableView
            .topToBottom(of: searchBar)
            .edgeToSuperViewHorizontal()
            .bottomToSuperview()
    }
    
    private func fetchData() {
        viewModel = ZipCodeListViewModel()
        Loading.shared.showLoading(view)
        viewModel?.fetchData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            Loading.shared.stopLoading()
        }
    }
}

extension ZipCodeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.zipCodeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? ZipCodeCell else {
            return UITableViewCell()
        }
        cell.awakeFromNib()
        let zipCode = viewModel?.zipCodeList[indexPath.row]
        cell.loadData(zipCode: zipCode)
        
        return cell
    }
}

extension ZipCodeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.viewModel?.filterZipCode(with: textSearched)
            self?.tableView.reloadData()
        })
    }
}
