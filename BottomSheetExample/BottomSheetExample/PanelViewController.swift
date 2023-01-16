//
//  PanelViewController.swift
//  BottomSheetExample
//
//  Created by 김지수 on 2023/01/16.
//

import UIKit
import FloatingPanel
import SnapKit


class PanelViewController: UIViewController {
    
    var tableViewCount: Int = 100
    var tableArray: [Int] = []
    
    var someButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close Panel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(nil, action: #selector(panelDismiss), for: .touchUpInside)
        return button
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        return table
    }()
    
    var panel: FloatingPanelController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupTableView()
    }
    
    func setupData() {
        var array: [Int] = []
        for i in 1...tableViewCount {
            array.append(i)
        }
        tableArray = array
    }
    
    func setupTableView() {
        tableView.register(SomeCell.self, forCellReuseIdentifier: "SomeCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        self.view.addSubview(someButton)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view).inset(20)
            $0.leading.trailing.equalTo(view).inset(15)
            $0.bottom.equalTo(view)
        }
        someButton.snp.makeConstraints {
            $0.trailing.top.equalTo(view).inset(50)
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
    
    @objc func panelDismiss() {
        self.panel?.dismiss(animated: true)
    }
}

extension PanelViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SomeCell") as? SomeCell else { return UITableViewCell() }
        cell.configure(index: tableArray[indexPath.row])
        return cell
    }
    
    
}

class SomeCell: UITableViewCell {
    var someLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    func configure(index: Int) {
        self.contentView.addSubview(someLabel)
        someLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        someLabel.text = "\(index)번째 Cell"
    }
}
