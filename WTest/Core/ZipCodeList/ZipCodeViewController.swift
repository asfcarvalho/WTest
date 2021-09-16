//
//  ZipCodeViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 14/09/21.
//

import UIKit

class ZipCodeViewController: UIViewController {
    
    var viewModel: ZipCodeListViewModel?
    var handleZipCodeSelected: ((String) -> Void)?
    
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
                
        configUI()
        configKeyboardManager()
        fetchData()
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
        self.view.layoutIfNeeded()
      })
    }
    
    private func configKeyboardManager() {
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
    
    private func configUI() {
        view.backgroundColor = .white
        
        searchBar.delegate = self
        tableView.register(ZipCodeCell.self, forCellReuseIdentifier: ZipCodeCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
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

extension ZipCodeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.zipCodeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ZipCodeCell.identifier) as? ZipCodeCell else {
            return UITableViewCell()
        }
        cell.awakeFromNib()
        let zipCode = viewModel?.zipCodeList[indexPath.row]
        cell.loadData(zipCode: zipCode)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        handleZipCodeSelected?(viewModel?.getZipCodeDescription(from: indexPath.row) ?? "")
        navigationController?.popViewController(animated: true)
    }
}

extension ZipCodeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        viewModel?.filterZipCode(with: textSearched)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
