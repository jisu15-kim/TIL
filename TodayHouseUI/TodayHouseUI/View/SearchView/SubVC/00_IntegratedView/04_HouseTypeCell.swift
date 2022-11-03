//
//  04_HouseTypeCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/03.
//

import UIKit

class HouseTypeCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var houseTypeData: [IntegratedVcData] = []
    var collectionView: UICollectionView?
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "주거형태 & 가족형태별 집들이"
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
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
//        layout.estimatedItemSize = CustomFlowLayout.automaticSize
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(HouseTypeDetailCell.self, forCellWithReuseIdentifier: "HouseTypeDetailCell")
        addSubview(collectionView!)
        setupConstraints()
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView?.isScrollEnabled = false
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
            collectionView.heightAnchor.constraint(equalToConstant: 250)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return houseTypeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseTypeDetailCell", for: indexPath) as? HouseTypeDetailCell else { return UICollectionViewCell() }
        let data = houseTypeData[indexPath.row]

        cell.data = data
        cell.setupStackView()
        cell.titleLabel.text = data.title
        cell.image.image = data.image
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = ((self.collectionView!.bounds.width - flow.minimumLineSpacing * 3) - 30) / 4

        return CGSize(width: width, height: width + 30)
    }
}

class HouseTypeDetailCell: UICollectionViewCell {
    var data: IntegratedVcData?
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 11
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    var stack: UIStackView?
    
    func setupStackView() {
        self.container.addSubview(image)
        self.stack = UIStackView(arrangedSubviews: [container, titleLabel])
        self.stack?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack!)
        setupConstraint()
        stack!.spacing = 10
        stack!.axis = .vertical
    }
    
    func setupConstraint() {
        guard let stack = self.stack else { return }
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 7),
            image.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -7),
            image.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 7),
            image.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -7),
            
            container.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            container.heightAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1.0),
            
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 15)
            
        ])
    }
}
