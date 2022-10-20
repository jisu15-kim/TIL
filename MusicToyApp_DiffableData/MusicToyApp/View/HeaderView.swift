//
//  HeaderView.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/17.
//

import UIKit

final class HeaderView: UICollectionReusableView {

    let label = UILabel()
    let button = UIButton(type: .system)

    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        label.text = "새로운 아티스트"
        addSubview(stackView)
        stackView.addArrangedSubview(label)
//        button.setTitle("더보기", for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.addArrangedSubview(button)
        label.textColor = .white
        constraint()
    }
    
    func constraint() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
