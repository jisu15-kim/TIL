//
//  FindCategoryCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/02.
//

import UIKit

class AreaCategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionViewHeight = CGFloat(180)
    var areaCategoryData: [IntegratedVcData] = []
    var collectionView: UICollectionView?
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "공간별 사진 찾기"
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
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.stackView = stack
        
        addSubview(stackView!)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(AreaCategoryDetailCell.self, forCellWithReuseIdentifier: "AreaCategoryDetailCell")
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
        let cvHeight = (collectionView.bounds.width - 80) / 4.5
        
        NSLayoutConstraint.activate([
            
            stackView!.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 20),
            stackView!.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            stackView!.topAnchor.constraint(equalTo: self.topAnchor),
            stackView!.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: stackView!.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: cvHeight + 40)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areaCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCategoryDetailCell", for: indexPath) as? AreaCategoryDetailCell else { return UICollectionViewCell() }
        let data = areaCategoryData[indexPath.row]

        cell.data = data
        cell.setupUI()
        cell.titleLabel.text = data.title
        cell.image.image = data.image
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = ((self.collectionView!.bounds.width - flow.minimumInteritemSpacing * 4) - 30) / 4.5
        
        return CGSize(width: width, height: width + 30)
    }
}

class AreaCategoryDetailCell: UICollectionViewCell {
    var data: IntegratedVcData?
    
    var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.systemGray5.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        addSubview(image)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor, multiplier: 1.0),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10)
        ])
    }
    
    func configure() {
        image.image = data?.image
        titleLabel.text = data?.title
    }
}
