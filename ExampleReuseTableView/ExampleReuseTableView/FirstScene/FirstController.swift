//
//  FirstController.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import UIKit
import SnapKit

class FirstController: UIViewController {
    //MARK: - Properties
    let viewModel = FirstViewModel()
    lazy var tableView = MyListTableView(userListRelay: self.viewModel.userList)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        self.viewModel.requestUserList()
    }
    
    //MARK: - Methods
    private func setupUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "첫번째 뷰"
    }
}
