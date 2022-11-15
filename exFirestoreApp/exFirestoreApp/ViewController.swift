//
//  ViewController.swift
//  exFirestoreApp
//
//  Created by 김지수 on 2022/11/10.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirestoreError: Error {
    case firestoreError(Error?)
    case decodedError(Error?)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    let myFirestore = MyFirestore()
    var message: [Message] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        subscribeFirestore()
    }
    
    // Send 버튼 클릭시
    @IBAction func sendButtonClicked(_ sender: Any) {
        guard let data = textField.text else { return }
//        let docToWrite = DocumentReference(from: <#T##Decoder#>)
        let message = Message(id: "jisu", content: data, docId: nil)
        
        myFirestore.save(message) { error in
            print("세이브? \(message)")
            guard let error = error else { return }
            print(error)
        }
    }
    
    // Firebase 구독 !
    private func subscribeFirestore() {
        myFirestore.subscribe(id: "jisu") { [weak self] result in
            switch result {
            case .success(let messages):
                self?.message.append(contentsOf: messages)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func delete() {
        // 삭제 함수 추가 예정
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as? TextCell else { return UITableViewCell() }
        print(self.message[indexPath.row])
        let data = self.message[indexPath.row]
        cell.data = data
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            
            let data = self.message[indexPath.row]
            self.delete()
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
