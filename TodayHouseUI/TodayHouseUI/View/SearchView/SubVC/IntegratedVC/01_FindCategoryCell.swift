//
//  FindCategoryCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/02.
//

import UIKit

class FindCategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionViewHeight = CGFloat(180)
    var findCategoryData: [IntegratedVcData] = []
    var collectionView: UICollectionView?
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(FindCategoryDetailCell.self, forCellWithReuseIdentifier: "FindCategoryDetailCell")
        addSubview(collectionView!)
        collectionView?.register(SearchCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchCollectionHeaderView")
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
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return findCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCollectionHeaderView", for: indexPath) as? SearchCollectionHeaderView else { return UICollectionReusableView() }
            header.label.text = "카테고리별 상품 찾기"
            header.descriptionLabel.text = ""
            header.setupSubView()
            header.setupConstraints()
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindCategoryDetailCell", for: indexPath) as? FindCategoryDetailCell else { return UICollectionViewCell() }
        let data = findCategoryData[indexPath.row]
        print("Data : \(data)")
        cell.data = data
        cell.setupUI()
        cell.titleLabel.text = data.title
        cell.image.image = data.image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = ((self.collectionView!.bounds.width - flow.minimumInteritemSpacing * 4) - 30) / 4.5
        
        return CGSize(width: width, height: collectionViewHeight)
    }
}

class FindCategoryDetailCell: UICollectionViewCell {
    var data: IntegratedVcData?
    
    var image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.systemGray5.cgColor
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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
