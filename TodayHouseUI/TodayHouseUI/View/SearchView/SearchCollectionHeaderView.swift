//
//  SearchCollectionHeaderView.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/02.
//

import UIKit

class SearchCollectionHeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView: UIStackView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {
        let stack = UIStackView(arrangedSubviews: [label, descriptionLabel])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.stackView = stack
        
        addSubview(stackView!)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView!.topAnchor.constraint(equalTo: self.topAnchor),
            stackView!.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
