//
//  MainViewController.swift
//  StickyHeaderTest
//
//  Created by 김지수 on 2022/11/06.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var upperHeaderHeight: NSLayoutConstraint!
    
    var headerMax: Float = 100.0
    var dummyData: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupCollectionView()
    }
    
    func setupData() {
        for i in 0...100 {
            dummyData.append(i)
        }
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.sectionHeadersPinToVisibleBounds = true
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DummyCell.self, forCellWithReuseIdentifier: "DummyCell")
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DummyHeader")
        
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummyData.count / 10
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "DummyHeader", for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
        header.setupUI()
        let index = indexPath.section + 1
        header.titleLabel.text = "\(index)번 섹션 헤더 셀🔥"
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCell", for: indexPath) as? DummyCell else { return UICollectionViewCell() }
        let data = dummyData[indexPath.row] + 1
        let section = indexPath.section
        cell.setupUI()
        cell.samplelabel.text = "\(section)\(data)번 샘플 셀"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = self.collectionView.bounds.width
        return CGSize(width: width, height: 40)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset: Float = Float(-scrollView.contentOffset.y + CGFloat(self.headerMax))
        print(offset)
        if 0 <= offset {
            self.upperHeaderHeight.constant = CGFloat(offset)
        // 순간적으로 offset 값이 벌어진 경우를 대비
        } else if self.headerMax < Float(scrollView.contentOffset.y) {
            self.upperHeaderHeight.constant = CGFloat(0)
        }
        
//        if 0 <= offset {
//            self.upperHeaderHeight.constant = CGFloat(offset)
//        // 순간적으로 offset 값이 벌어진 경우를 대비
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width
        return CGSize(width: width, height: 50)
    }
}
