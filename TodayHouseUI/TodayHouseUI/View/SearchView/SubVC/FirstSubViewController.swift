//
//  FirstSubViewController.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/01.
//

import UIKit

class FirstSubViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var dataManager = DataManager()
    var integratedVcDataList: [IntegratedVcData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.integratedVcDataList = dataManager.getIntegratedVcDataList()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.addSubview(collectionView!)
        updateViewConstraints()
        collectionView!.register(HotTopicCell.self, forCellWithReuseIdentifier: "HotTopicCell")
        collectionView!.register(FindCategoryCell.self, forCellWithReuseIdentifier: "FindCategoryCell")
        collectionView!.delegate = self
        collectionView!.dataSource = self
//        collectionView!.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15)
    }
    
    private func constraitsCollectionview() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension FirstSubViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count: \(SearchViewCellType.allCases.count)")
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotTopicCell", for: indexPath) as? HotTopicCell else { return UICollectionViewCell() }
            let data = integratedVcDataList.filter { data in
                data.type == .hot
            }
            cell.hotData = data
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FindCategoryCell", for: indexPath) as? FindCategoryCell else { return UICollectionViewCell() }
            let data = integratedVcDataList.filter { data in
                data.type == .categoryFind
            }
            cell.findCategoryData = data
            cell.setupCollectionView()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension FirstSubViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView!.bounds.width
        
        return CGSize(width: width, height: 300)
    }
}
