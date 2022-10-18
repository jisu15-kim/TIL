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
    
    var dataSource: UICollectionViewDiffableDataSource<Section, NewArtist>!
    
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
        //self.mainCollectionView.register(UINib(nibName: "NewArtistCell", bundle: nil), forCellWithReuseIdentifier: "NewArtistCell")
        mainCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        mainCollectionView.alwaysBounceVertical = false
        
        mainCollectionView.collectionViewLayout = self.newArtistLayout()
        configureDataSource()
        header()
        newArtistsnapshot()
    }
    
    func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, NewArtist>(collectionView: self.mainCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as? ArtistCell else { preconditionFailure() }
            cell.newArtist = item
            cell.setupUI()
            return cell
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, NewArtist>()
        snapshot.appendSections([Section.Artist])
        snapshot.appendItems(newArtist, toSection: Section.Artist)
        dataSource.apply(snapshot)
    }
    
    private func newArtistLayout() -> UICollectionViewCompositionalLayout {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
        //        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.45), heightDimension: .estimated(200)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
        //        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 16)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
