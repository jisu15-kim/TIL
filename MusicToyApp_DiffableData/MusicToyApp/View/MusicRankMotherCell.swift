//
//  MusicRankMotherCell.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/19.
//

import UIKit

class MusicRankMotherCell: UICollectionViewCell {

    @IBOutlet weak var musicRankCollectionView: UICollectionView!
    
//    var music: Music?
    var musicDetail: [MusicDetail] = []
    
    enum Section: CaseIterable {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MusicDetail>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        self.musicRankCollectionView.register(UINib(nibName: "MusicRankCell", bundle: nil), forCellWithReuseIdentifier: "MusicRankCell")
        musicRankCollectionView.collectionViewLayout = layout()
        musicRankCollectionView.isScrollEnabled = false
        
        constraintCollectionView()
        configureDataSource()
        snapshot()
    }
    
    func constraintCollectionView() {
        musicRankCollectionView.translatesAutoresizingMaskIntoConstraints = false
        musicRankCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        musicRankCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        musicRankCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        musicRankCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, MusicDetail>(collectionView: musicRankCollectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicRankCell", for: indexPath) as? MusicRankCell else { return UICollectionViewCell() }
            cell.music = item
            cell.configure()
            
            return cell
        })
    }
    
    func snapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MusicDetail>()
        snapshot.appendSections([.main])
        snapshot.appendItems(musicDetail, toSection: .main)
        dataSource.apply(snapshot)
    }
}
