//
//  CreateViewController.swift
//  NetworkTest
//
//  Created by 김지수 on 2022/12/27.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    var delegate: CreateVCDelegate?
    
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        let title = titleTextField.text
        let body = bodyTextField.text
        
        dataManager.postNetworkData(param: Model(userId: 1, title: title!, body: body!)) { [weak self] model in
            self?.delegate?.createData(item: model)
            self?.dismiss(animated: true)
        }
    }
}
