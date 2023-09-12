//
//  UserCell.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
    //MARK: - Properties
    static let identifier = "UserCell"

    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var user: UserResult? {
        didSet {
            configure()
        }
    }
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    //MARK: - Methods
    private func setupUI() {
        userImageView.layer.cornerRadius = 90 / 2
        userImageView.clipsToBounds = true
    }
    
    private func configure() {
        guard let user = user else { return }
        
        userEmailLabel.text = user.email
        userNameLabel.text = user.name.first + user.name.last
        
        let imageUrl = URL(string: user.picture.medium)
        userImageView.kf.indicatorType = .activity
        userImageView.kf.setImage(with: imageUrl)
    }
}
