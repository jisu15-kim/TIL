//
//  ViewController.swift
//  DependencyInjection_Example
//
//  Created by 김지수 on 2023/01/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        if testTextField.text != nil && testTextField.text != "" {
            let vc = DetailViewController.initViewController(title: testTextField.text!, delegate: self)
            present(vc, animated: true)
        }
    }
}

extension ViewController: SomeProtocol {
    func doSomething() {
        print(#function)
    }
}

protocol SomeProtocol {
    func doSomething()
}

