//
//  PhotoRecommandKeywordCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/04.
//

import UIKit

class PhotoRecommandKeywordCell: UICollectionViewCell {
    var data: RecommandSearchKeyword?
    
    let keyword: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        addSubview(keyword)
        
        NSLayoutConstraint.activate([
            keyword.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            keyword.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            keyword.topAnchor.constraint(equalTo: self.topAnchor),
            keyword.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.backgroundColor = .systemGray6
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray5.cgColor
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
