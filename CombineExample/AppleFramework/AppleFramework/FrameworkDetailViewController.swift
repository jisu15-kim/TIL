//
//  FrameworkDetailViewController.swift
//  AppleFramework
//
//  Created by joonwon lee on 2022/05/01.
//

import UIKit
import Combine
import SafariServices

class FrameworkDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let item = PassthroughSubject<AppleFramework, Never>()
    var learnMoreTapped = PassthroughSubject<Any, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    var framework: AppleFramework = AppleFramework(name: "Unknown", imageName: "", urlString: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        bind()
    }
    
    func bind() {
        item
            .receive(on: RunLoop.main)
            .sink { [weak self] item in
                self?.framework = item
                self?.imageView.image = UIImage(named: item.imageName)
                self?.titleLabel.text = item.name
                self?.descriptionLabel.text = item.description
            }.store(in: &subscriptions)
        
        learnMoreTapped
            .receive(on: RunLoop.main)
            .sink { [weak self] item in
                guard let url = URL(string: self?.framework.urlString ?? "") else {
                    return
                }
                let safari = SFSafariViewController(url: url)
                self?.present(safari, animated: true)
            }.store(in: &subscriptions)
    }
    
    func updateUI() {
        imageView.image = UIImage(named: framework.imageName)
        titleLabel.text = framework.name
        descriptionLabel.text = framework.description
    }
    
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        learnMoreTapped.send(sender)
    }
}
