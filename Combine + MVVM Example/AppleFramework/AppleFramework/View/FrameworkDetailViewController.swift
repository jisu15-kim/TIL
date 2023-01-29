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
    
    var subscriptions = Set<AnyCancellable>()
    
    var viewModel: FrameworkDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    func bind() {
        
        // UI세팅
        viewModel.framework
            .receive(on: RunLoop.main)
            .sink { [weak self] framework in
                self?.imageView.image = UIImage(named: framework.imageName)
                self?.titleLabel.text = framework.name
                self?.descriptionLabel.text = framework.description
            }.store(in: &subscriptions)
        
        // 버튼 클릭
        viewModel.buttonTapped
            .receive(on: RunLoop.main)
            .compactMap { URL(string: $0.urlString) }
            .sink { [weak self] url in
                let safari = SFSafariViewController(url: url)
                self?.present(safari, animated: true)
            }.store(in: &subscriptions)
    }
    
    @IBAction func learnMoreTapped(_ sender: Any) {
        viewModel.learnMoreTapped()
    }
}
