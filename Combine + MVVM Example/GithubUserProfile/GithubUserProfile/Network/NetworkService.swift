//
//  Network.swift
//  GithubUserSearch
//
//  Created by joonwon lee on 2022/05/25.
//

import Foundation
import Alamofire
import Combine

final class NetworkService {

    func getProfile(keyword: String, completion: @escaping (UserProfile?) -> Void ) {
        let url = "https://api.github.com/users/\(keyword)"
        
        AF.request(url)
            .responseDecodable(of: UserProfile.self) { result in
                switch result.result {
                case .success(let response):
                    completion(response)
                case .failure(let error):
                    print("실패: \(error)")
                    completion(nil)
                }
            }
    }
}
