//
//  RecommnadKeywordCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/02.
//

import UIKit

class RecommandkeywordCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var recommandCategoryData: [IntegratedVcData] = []
    var collectionView: UICollectionView?
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "사진 추천 키워드"
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
        collectionView?.register(RecommandKeywordDetailCell.self, forCellWithReuseIdentifier: "RecommandKeywordDetailCell")
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
        return recommandCategoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandKeywordDetailCell", for: indexPath) as? RecommandKeywordDetailCell else { return UICollectionViewCell() }
        let data = recommandCategoryData[indexPath.row]

        cell.data = data
        cell.setupUI()
        cell.titleLabel.text = data.title
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = ((self.collectionView!.bounds.width - flow.minimumInteritemSpacing * 4) - 30) / 4.5
        
        return CGSize(width: width, height: width + 30)
    }
}

class RecommandKeywordDetailCell: UICollectionViewCell {
    var data: IntegratedVcData?
    
    var viewA: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewB: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 10)
        ])
    }
    
    func configure() {
        titleLabel.text = data?.title
    }
}
