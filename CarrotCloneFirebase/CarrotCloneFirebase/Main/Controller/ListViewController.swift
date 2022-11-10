//
//  ViewController.swift
//  CarrotCloneFirebase
//
//  Created by 김지수 on 2022/11/08.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

protocol UserDataDelegate: AnyObject {
    func fetchUserData(data: GIDGoogleUser)
}

class ListViewController: UIViewController {
    
    static let shared = ListViewController()
    var userData: User?
    let db = Firestore.firestore()
    
    @IBOutlet weak var loginStatusLabel: UILabel!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var data: [Product] = []
    private var isLogin: Bool = false {
        didSet {
            if isLogin == true {
                self.loginStatusLabel.text = "성공"
                self.signButton.setTitle("로그아웃", for: .normal)
            } else {
                self.loginStatusLabel.text = "False"
                self.signButton.setTitle("로그인", for: .normal)
                self.userEmailLabel.text = "사용자 정보 없음"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logout()
        setupData()
        setupCollectionView()
        checkLoginStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userData = Auth.auth().currentUser
        guard let user = userData else { return }
        self.isLogin = true
        fetchUserData(data: user)
    }
    
    func setupData() {
        self.title = "리스트"
    }
    
    func checkLoginStatus() {
        if isLogin == false {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginPageViewController")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func fetchUserData(data: User) {
        print("데이터 넘어왔어요")
        userEmailLabel.text = "\(data.displayName ?? "") / \(data.email ?? "")"
        fetchListData()
    }
    
    func fetchListData() {
        db.collection("Product").getDocuments { (snapshot, error) in

            if error == nil && snapshot != nil {
                
                var dataList: [Product] = []
                
                for document in snapshot!.documents {
                    let data = document.data()
                    let title = data["title"]
                    let region = data["region"]
                    let upLoadTime = data["uploadTime"]
                    let price = data["price"]
                    let body = data["body"]
                    let product = Product(title: title, region: region, upLoadTime: upLoadTime, price: price, body: body)
                    dataList.append(product)
                }
                print(self.data)
            }
        }
    }
    
    func logout() {
        if isLogin == true {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.isLogin = false
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }

    @IBAction func signButtonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "로그인" {
            checkLoginStatus()
        } else {
            logout()
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell else { return UICollectionViewCell() }
        return cell
    }
}
