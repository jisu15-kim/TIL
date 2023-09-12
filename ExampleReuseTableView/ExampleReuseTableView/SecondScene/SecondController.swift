//
//  SecondController.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import UIKit
import SnapKit

class SecondController: UIViewController {
    //MARK: - Properties
    let viewModel = SecondViewModel()
    lazy var tableView = MyListTableView(userListRelay: self.viewModel.userList)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.text = "내가 연락했던 사람들"
        return label
    }()
    
    lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bolt.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        return button
    }()
    
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
        
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.height.equalTo(40)
        }
        
        self.view.addSubview(reloadButton)
        reloadButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.width.height.equalTo(35)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).inset(-10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "두번째 뷰"
    }
    
    @objc private func refreshButtonTapped() {
        self.viewModel.userList.accept([])
        self.viewModel.requestUserList()
    }
}
