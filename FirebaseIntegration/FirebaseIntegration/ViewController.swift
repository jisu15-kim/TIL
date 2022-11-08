//
//  ViewController.swift
//  FirebaseIntegration
//
//  Created by 김지수 on 2022/11/07.
//

import UIKit
import Firebase
import GoogleSignIn

enum LoginStatus: String {
    case login = "로그인됨"
    case logout = "로그아웃됨"
}

struct DataModel {
    var text: String
}

class ViewController: UIViewController {
    
    let db = Database.database().reference()
    
    @IBOutlet weak var loginStatus: UILabel!
    
    var isLogin: Bool = false {
        didSet {
            if isLogin == true {
                guard let user = Auth.auth().currentUser else { return }
                firstData.text = user.email
                loginStatus.text = LoginStatus.login.rawValue
            } else {
                loginStatus.text = LoginStatus.logout.rawValue
                firstData.text = "로그아웃되었어요💡"
            }
        }
    }
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var firstData: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readData()
        loginStatus.text = LoginStatus.logout.rawValue
    }
    
    func readData() {
        db.child("firstData").observeSingleEvent(of: .value) { snapshot in
            print("---> \(snapshot)")
            let value = snapshot.value as? String ?? ""
            DispatchQueue.main.async {
                self.firstData.text = value
                print(value)
            }
        }
    }
    
    func createData() {
        self.db.child("Company01").setValue(["lunch":"Salad", "Dinner":"Beef"])
        self.db.child("Company02").setValue(["lunch":"씨리얼", "Dinner":"코코넛"])
        self.db.child("Company03").setValue(["lunch":"돈까스", "Dinner":"캐비어"])
        
        db.observeSingleEvent(of: .value) { snapshot in
            guard let snapData = snapshot.value as? [String:Any] else { return }
            dump(snapData)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        createData()
    }
    @IBAction func signInButtonTapped(_ sender: GIDSignInButton) {
        // 구글 로그인 인증
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else { return }
            
            // 인증을 해도 계정은 따로 등록을 해주어야 한다.
            // 구글 인증 토큰 받아서 -> 사용자 정보 토큰 생성 -> 파이어베이스 인증에 등록
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            // 사용자 정보 등록
            Auth.auth().signIn(with: credential) { _, _ in
                // 사용자 등록 후 처리할 코드
                self.isLogin = true
            }
        }
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.isLogin = false
        } catch let signOutError as NSError {
            print("로그아웃 Error발생:", signOutError)
        }
    }
}



