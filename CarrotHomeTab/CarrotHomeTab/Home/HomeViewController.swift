//
//  HomeViewController.swift
//  CarrotHomeTab
//
//  Created by 김지수 on 2022/11/18.
//

import UIKit

// 홈 뷰모델 만들기
// 뷰 모델은 리스트 가져오기

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "D") as! DetailViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
