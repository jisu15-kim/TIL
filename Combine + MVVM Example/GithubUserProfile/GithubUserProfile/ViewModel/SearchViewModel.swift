//
//  SearchViewModel.swift
//  GithubUserProfile
//
//  Created by 김지수 on 2023/01/30.
//

import UIKit
import Combine

final class UserProfileViewModel {
    
    init(item: UserProfile? = nil) {
        self.items = CurrentValueSubject(item)
    }
    
    let items: CurrentValueSubject<UserProfile?, Never>
    
    func searchButtonTapped(keyword: String) {
        NetworkService().getProfile(keyword: keyword) { [weak self] profile in
            self?.items.send(profile)
        }
    }
}
