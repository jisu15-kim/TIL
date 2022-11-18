//
//  CustomBarItem.swift
//  CarrotHomeTab
//
//  Created by 김지수 on 2022/11/18.
//

import UIKit

// CustomBarItem Init을 위한 config
struct CustomBarItemConfiguration {
    
    typealias Handler = () -> Void
    
    let title: String?
    let image: UIImage?
    let handler: Handler
    
    init(title: String? = nil, image: UIImage? = nil, handler: @escaping Handler) {
        self.title = title
        self.image = image
        self.handler = handler
    }
}

final class CustomBarItem: UIButton {
    // 타이틀, 이미지, 액션 핸들러
    var customBarItemConfig: CustomBarItemConfiguration
    
    var handler: (() -> Void)?
    
    init(config: CustomBarItemConfiguration) {
        self.customBarItemConfig = config
        super.init(frame: .zero)
        setupStyle()
        updateConfig()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupStyle() {
        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        self.titleLabel?.textColor = .white
        self.titleLabel?.tintColor = .white
        self.tintColor = .white
    }
    
    private func updateConfig() {
        self.setTitle(customBarItemConfig.title, for: .normal)
        self.setImage(customBarItemConfig.image, for: .normal)
    }
    
    
    @objc func buttonTapped() {
        customBarItemConfig.handler()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
