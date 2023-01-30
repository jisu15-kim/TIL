//
//  SearchViewController.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import UIKit
import Combine
import Kingfisher

class UserProfileViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    
    private var viewModel: UserProfileViewModel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = UserProfileViewModel()
        setupUI()
        bind()
        embedSearchControl()
    }
    
    private func setupUI() {
        thumbnail.layer.cornerRadius = thumbnail.frame.width / 2
    }
    
    private func bind() {
        
        viewModel.items
            .receive(on: RunLoop.main)
            .sink { [weak self] user in
                self?.update(user)
            }.store(in: &subscriptions)
    }
    
    private func update(_ user: UserProfile?) {
        if let user = user {
            self.nameLabel.text = user.name
            self.loginLabel.text = user.login
            self.followerLabel.text = "follower: \(user.followers)"
            self.followingLabel.text = "following: \(user.following)"
            self.thumbnail.kf.setImage(with: user.avatarUrl)
        } else {
            self.nameLabel.text = "n/a"
            self.loginLabel.text = "n/a"
            self.followerLabel.text = ""
            self.followingLabel.text = ""
            self.thumbnail.image = nil
        }
    }
    
    private func embedSearchControl() {
        self.navigationItem.title = "Search"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "userName"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
    }
}

extension UserProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let keyword = searchController.searchBar.text
        print("KEYWORK: \(keyword)")
    }
}

extension UserProfileViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchBar.text, !keyword.isEmpty else { return }
        viewModel.searchButtonTapped(keyword: keyword)
    }
}
