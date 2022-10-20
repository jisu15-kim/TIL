//
//  MusicRankMotherCell.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/19.
//

import UIKit

class MusicRankMotherCell: UICollectionViewCell {

    @IBOutlet weak var musicRankCollectionView: UICollectionView!
    
    var music: Music?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCollectionView() {
        self.musicRankCollectionView.register(UINib(nibName: "MusicRankCell", bundle: nil), forCellWithReuseIdentifier: "MusicRankCell")
        musicRankCollectionView.dataSource = self
        musicRankCollectionView.delegate = self
    }

    func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension MusicRankMotherCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let safeData = music else { return 0 }
        return safeData.musicDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = musicRankCollectionView.dequeueReusableCell(withReuseIdentifier: "MusicRankCell", for: indexPath) as? MusicRankCell else { return UICollectionViewCell() }
        let safeData = music!
        cell.music = safeData.musicDetail[indexPath.row]
        cell.configure()
        
        return cell
    }
}

extension MusicRankMotherCell: UICollectionViewDelegate {
    
}
