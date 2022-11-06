//
//  01_PhotoViewController.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/04.
//

import UIKit

class RecommandKeywordViewController: UIViewController {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "추천 검색어"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
//    let dataManager = DataManager()
    var dataModel: [RecommandSearchKeyword]
    var collectionView: UICollectionView?
    
    init(dataModel: [RecommandSearchKeyword]) {
        self.dataModel = dataModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.dataModel = dataManager.getRkData()
        setupCollectionView()
        setupConstraint()

    }
    
    private func setupCollectionView() {
        let layout = CustomFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView!.register(PhotoRecommandKeywordCell.self, forCellWithReuseIdentifier: "PhotoRecommandKeywordCell")
        self.view.addSubview(collectionView!)
        setupConstraint()
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
    }
    
    private func setupConstraint() {
        guard let collectionView = collectionView else { return }
        self.view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            headerLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            headerLabel.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            collectionView.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ])
    }
}

extension RecommandKeywordViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoRecommandKeywordCell", for: indexPath) as? PhotoRecommandKeywordCell else { return UICollectionViewCell() }
//        let data = self.dataModel.filter { data in
//            data.type == .photo
//        }
        
        cell.setupUI()
        cell.keyword.text = self.dataModel[indexPath.row].title
        return cell
    }
}

extension RecommandKeywordViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let dummy = dataModel[indexPath.item].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)])

        return CGSize(width: dummy.width + 35, height: dummy.height + 18)
    }
}
