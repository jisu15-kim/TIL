//
//  ViewController.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/17.
//

import UIKit

class ViewController: UIViewController {
    
    var newArtist: [NewArtist] = []
    var music: [Music] = []
    let dataManager = DataManager()
    
    enum Section: CaseIterable {
        case Artist
        case Music
    }
    
    enum Item: CaseIterable {
        case Artist
        case Music
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    
    private typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<HeaderView>
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        setupCollectionView()
    }
    
    private func setupData() {
        newArtist = dataManager.getNewArtistData()
        music = dataManager.getMusicData()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .black
        title = "Music"
    }
    
    private func setupCollectionView() {
        self.mainCollectionView.backgroundColor = .black
        self.mainCollectionView.register(UINib(nibName: "MusicRankMotherCell", bundle: nil), forCellWithReuseIdentifier: "MusicRankMotherCell")
        mainCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        mainCollectionView.alwaysBounceVertical = false
        
        mainCollectionView.collectionViewLayout = self.newArtistLayout()
        configureDataSource()
        header()
        newArtistsnapshot()
        print(music)
    }
    
    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: self.mainCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as? ArtistCell else { preconditionFailure() }
                guard let newArtist = item as? NewArtist else { return nil }
                cell.newArtist = newArtist
                cell.setupUI()
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicRankMotherCell", for: indexPath) as? MusicRankMotherCell else { preconditionFailure() }
                guard let music = item as? Music else { return nil }
                cell.music = music
                cell.setupCollectionView()
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    // 헤더뷰 생성
    func header() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            // kind가 맞는지 체크
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
            //            let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            return view
        }
    }
    
    private func newArtistsnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.Artist, .Music])
        snapshot.appendItems(newArtist, toSection: Section.Artist)
        snapshot.appendItems(music, toSection: Section.Music)
        dataSource.apply(snapshot)
    }
    
    private func newArtistLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                //        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .estimated(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                return section
                
            } else if sectionNumber == 1 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                //        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                return section
            } else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                //        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .estimated(200)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                return section
            }
        }
    }
}
