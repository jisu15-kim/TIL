//
//  MyListTableView.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class MyListTableView: UITableView {
    //MARK: - Properties
    let userList: BehaviorRelay<[UserResult]>
    private let disposeBag = DisposeBag()
    //MARK: - Lifecycle
    init(userListRelay: BehaviorRelay<[UserResult]>) {
        self.userList = userListRelay
        super.init(frame: .zero, style: .plain)
        self.register(UINib(nibName: UserCell.identifier, bundle: nil), forCellReuseIdentifier: UserCell.identifier)
        self.rowHeight = UITableView.automaticDimension
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func bind() {
        // 데이터 바인딩
        self.userList
            .bind(to: self.rx.items) { tableView, row, item in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: IndexPath(row: row, section: 0)) as? UserCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.user = item
                return cell
            }
            .disposed(by: disposeBag)
        
        // 탭 이벤트
        self.rx.modelSelected(UserResult.self)
            .bind { result in
                print("👉\(result.name.first) 선택됨")
            }
            .disposed(by: disposeBag)
    }
}
