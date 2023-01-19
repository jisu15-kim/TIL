//
//  DetailViewController.swift
//  DependencyInjection_Example
//
//  Created by 김지수 on 2023/01/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var delegate: SomeProtocol?
    
    var mainTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // Considering your view controller resides in Main.storyboard and it's identifier is set to "MemeDetailVC"
    class func initViewController(title: String, delegate: SomeProtocol) -> DetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return DetailViewController() }
        vc.mainTitle = title
        vc.delegate = delegate
        return vc
    }
    
    static func doSomething() {
        
    }
    
    func setupUI() {
        titleLabel.text = mainTitle
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        delegate?.doSomething()
    }
}
