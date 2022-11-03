//
//  CollectionViewCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/03.
//

import UIKit

class RecommandGuideBookCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var recommandGuideBookData: [IntegratedVcData] = []
    var collectionView: UICollectionView?
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "추천 가이드북"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var stackView: UIStackView?
    
    func setupStackView() {
        let stack = UIStackView(arrangedSubviews: [label, descriptionLabel])
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.stackView = stack
        
        addSubview(stackView!)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        //        layout.estimatedItemSize = CustomFlowLayout.automaticSize
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(RecommandGuideBookDetailCell.self, forCellWithReuseIdentifier: "RecommandGuideBookDetailCell")
        addSubview(collectionView!)
        setupConstraints()
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView?.isScrollEnabled = true
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func setupConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            
            stackView!.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 20),
            stackView!.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            stackView!.topAnchor.constraint(equalTo: self.topAnchor),
            stackView!.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: stackView!.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandGuideBookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandGuideBookDetailCell", for: indexPath) as? RecommandGuideBookDetailCell else { return UICollectionViewCell() }
        let data = recommandGuideBookData[indexPath.row]
        
        cell.data = data
        cell.setupUI()
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.description
        cell.image.image = data.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = ((self.collectionView!.bounds.width - flow.minimumLineSpacing) - 30) * 0.7
        
        return CGSize(width: width, height: 100)
    }
}

class RecommandGuideBookDetailCell: UICollectionViewCell {
    var data: IntegratedVcData?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 11
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.text = "Sample Data"
        let attributedString = NSMutableAttributedString(string: label.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 13
        image.clipsToBounds = true
        return image
    }()
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 0
        view.clipsToBounds = true
        return view
    }()
    
    func setupUI() {
        
        addSubview(container)
        container.addSubview(image)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        setupConstraint()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            container.topAnchor.constraint(equalTo: self.topAnchor, constant: 22),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -22),
            container.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1.0),
            
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            image.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            
            titleLabel.leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 13),
            //stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 13)
        ])
        
        self.layer.cornerRadius = 22
        self.clipsToBounds = true
        self.backgroundColor = .systemGray6
    }
}
