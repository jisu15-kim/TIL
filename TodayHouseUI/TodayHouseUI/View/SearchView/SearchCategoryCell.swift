//
//  CategoryCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/01.
//

import UIKit

class SearchCategoryCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                label.textColor = #colorLiteral(red: 0.2151565254, green: 0.7715450525, blue: 0.9392927885, alpha: 1)
                line.backgroundColor = #colorLiteral(red: 0.2151565254, green: 0.7715450525, blue: 0.9392927885, alpha: 1)
            } else {
                label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
                label.textColor = .darkGray
                line.backgroundColor = .clear
            }
        }
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .darkGray
        label.minimumScaleFactor = 7
        return label
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(label)
        addSubview(line)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            line.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
}
