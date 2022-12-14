//
//  LoginPageViewController.swift
//  CarrotCloneFirebase
//
//  Created by 김지수 on 2022/11/09.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

class LoginPageViewController: UIViewController {
    
    weak var userDelegate: UserDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                self.dismiss(animated: true)
            }
        }
    }
}
