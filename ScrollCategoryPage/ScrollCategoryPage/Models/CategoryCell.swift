//
//  CategoryCell.swift
//  ScrollCategoryPage
//
//  Created by 김지수 on 2022/10/31.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                label.textColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
                line.backgroundColor = .systemIndigo
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
