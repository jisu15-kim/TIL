//
//  CollectionHeaderView.swift
//  StickyHeaderTest
//
//  Created by 김지수 on 2022/11/06.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
        self.backgroundColor = .white
    }
}
