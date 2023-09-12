//
//  UserNetworkManager.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import Foundation
import Alamofire

class UserNetworkManager {
    let url = "https://randomuser.me/api/?results=20&inc=name,email,picture"
    
    func requestUserList(completion: @escaping ([UserResult]) -> Void) {
        AF.request(url)
            .responseDecodable(of: User.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data.results)
                case .failure(let error):
                    print("🔥네트워크 에러발생: \(error)")
                }
            }
    }
}
