//
//  ADCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit

class ADCell: UITableViewCell {
    
    @IBOutlet weak var adCollectionView: UICollectionView!
    var ad: [AD]?
    
    private let gridFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCollectionView() {
        adCollectionView.register(UINib(nibName: "ADDetailCell", bundle: nil), forCellWithReuseIdentifier: "ADDetailCell")
        adCollectionView.dataSource = self
        adCollectionView.delegate = self
        adCollectionView.collectionViewLayout = gridFlowLayout
        adCollectionView.isPagingEnabled = true
        adCollectionView.showsVerticalScrollIndicator = false
        adCollectionView.showsHorizontalScrollIndicator = false
        
    }
}

extension ADCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = ad else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: "ADDetailCell", for: indexPath) as? ADDetailCell else { return UICollectionViewCell() }
        guard let data = ad else { return UICollectionViewCell() }
        
        cell.bannerImage.image = data[indexPath.row].image
        cell.setupUI()
        
        return cell
    }
}

extension ADCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.adCollectionView.bounds.width, height: self.adCollectionView.bounds.height)
    }
}
