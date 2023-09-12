//
//  ViewController.swift
//  ExampleReuseTableView
//
//  Created by 김지수 on 2023/09/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func firstViewTapped(_ sender: Any) {
        let vc = FirstController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func secondViewTapped(_ sender: Any) {
        let vc = SecondController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

