//
//  SecondViewModel.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import Foundation
import RxSwift
import RxRelay

class SecondViewModel {
    //MARK: - Properties
    // 초기값 빈 배열
    let userList = BehaviorRelay<[UserResult]>(value: [])
    let network = UserNetworkManager()
    
    //MARK: - Methods
    // API Call
    func requestUserList() {
        self.network.requestUserList { userList in
            self.userList.accept(userList)
        }
    }
}
