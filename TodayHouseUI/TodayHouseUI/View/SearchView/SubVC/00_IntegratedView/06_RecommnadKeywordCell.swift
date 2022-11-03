//
//  CollectionViewCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/03.
//

import UIKit

class RecommandKeywordCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var recommandKeywordData: [IntegratedVcData] = []
    var collectionView: UICollectionView?
    
    let dummy = "Dummy"
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "노하우 추천 키워드"
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
        let layout = CustomFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
//        layout.estimatedItemSize = CustomFlowLayout.automaticSize
        
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(RecommandKeywordDetailCell.self, forCellWithReuseIdentifier: "RecommandKeywordDetailCell")
        addSubview(collectionView!)
        setupConstraints()
        collectionView!.delegate = self
        collectionView!.dataSource = self
        collectionView?.isScrollEnabled = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func setupConstraints() {
        let height = (dummy.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).height + 10) * 4 + 100
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            
            stackView!.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 20),
            stackView!.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            stackView!.topAnchor.constraint(equalTo: self.topAnchor),
            stackView!.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: stackView!.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommandKeywordData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommandKeywordDetailCell", for: indexPath) as? RecommandKeywordDetailCell else { return UICollectionViewCell() }
        let data = recommandKeywordData[indexPath.row]

        cell.data = data
        cell.setupStackView()
        cell.titleLabel.text = data.title
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let flow = collectionViewLayout as? CustomFlowLayout else { return CGSize() }
//        let width = ((self.collectionView!.bounds.width - flow.minimumInteritemSpacing * 2) - 30) / 3
//        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let width = recommandKeywordData[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)])

        return CGSize(width: width.width + 39, height: width.height + 10)
    }
}


class RecommandKeywordDetailCell: UICollectionViewCell {
    var data: IntegratedVcData?
    
    var viewA: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewB: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var hashMark: UILabel = {
        let label = UILabel()
        label.text = "#"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stack: UIStackView?
    
    func setupStackView() {
        self.stack = UIStackView(arrangedSubviews: [viewA, hashMark, titleLabel, viewB])
        self.stack?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack!)
        setupConstraint()
        stack!.layer.cornerRadius = 18
        stack!.clipsToBounds = true
        stack!.layer.borderWidth = 1
        stack!.layer.borderColor = UIColor.systemGray5.cgColor
//        stack!.layer.shadowColor = UIColor.darkGray.cgColor
//        stack!.layer.masksToBounds = false
//        stack!.layer.shadowOffset = CGSize(width: 1, height: 1)
//        stack!.layer.shadowRadius = 2
//        stack!.layer.shadowOpacity = 0.05
    }
    
    func setupConstraint() {
        guard let stack = self.stack else { return }
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.heightAnchor.constraint(equalToConstant: 35),
            
            viewA.widthAnchor.constraint(equalToConstant: 13),
            viewB.widthAnchor.constraint(equalToConstant: 13),
            hashMark.widthAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    func configure() {
        titleLabel.text = data?.title
    }
}
