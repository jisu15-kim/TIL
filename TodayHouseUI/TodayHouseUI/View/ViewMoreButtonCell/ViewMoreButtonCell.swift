//
//  ViewMoreButtonCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/27.
//

import UIKit

class ViewMoreButtonCell: UITableViewCell {
//    weak var view: UIView!
    var viewMoreButton: UIButton! = {
       let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add button
        
        contentView.addSubview(viewMoreButton)
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//
        //Set constraints as per your requirements
        viewMoreButton.translatesAutoresizingMaskIntoConstraints = false
        viewMoreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        viewMoreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        viewMoreButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        viewMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
