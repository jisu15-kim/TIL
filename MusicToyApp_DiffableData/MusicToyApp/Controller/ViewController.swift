//
//  ViewController.swift
//  MusicToyApp
//
//  Created by 김지수 on 2022/10/17.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: -CollectionView 관련 변수/Enum 선언
    enum Section: CaseIterable {
        case Artist
        case Music
        case Playlist
    }
    
    enum Item: CaseIterable {
        case Artist
        case Music
        case Playlist
    }
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private typealias HeaderRegistration = UICollectionView.SupplementaryRegistration<HeaderView> //헤더 등록
    
    // MARK: -데이터 모델
    private var newArtist: [NewArtist] = []
    private var musicDetail: [MusicDetail] = []
    private var playList: [PlayList] = []
    private let dataManager = DataManager()
    

    // MARK: -함수

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        setupCollectionView()
    }
    
    private func setupData() {
        newArtist = dataManager.getNewArtistData()
        musicDetail = dataManager.getMusicData()
        playList = dataManager.getPlayListData()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .black
        title = "Music"
    }
    
    private func setupCollectionView() {
        self.mainCollectionView.backgroundColor = .black
        self.mainCollectionView.register(UINib(nibName: "MusicRankCell", bundle: nil), forCellWithReuseIdentifier: "MusicRankCell")
        self.mainCollectionView.register(UINib(nibName: "PlayListCell", bundle: nil), forCellWithReuseIdentifier: "PlayListCell")
        mainCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        //        mainCollectionView.alwaysBounceVertical = false
        mainCollectionView.collectionViewLayout = collectionViewLayout()
        
        configureDataSource()
        header()
        makeSnapshot()
        
    }
    
    private func configureDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: self.mainCollectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch indexPath.section {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as? ArtistCell else { preconditionFailure() }
                guard let newArtist = item as? NewArtist else { return nil }
                cell.newArtist = newArtist
                cell.setupUI()
                return cell
            case 1:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicRankCell", for: indexPath) as? MusicRankCell else { preconditionFailure() }
                guard let music = item as? MusicDetail else { return nil }
                cell.music = music
                cell.configure()
                return cell
            case 2:
                print("case 2")
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayListCell", for: indexPath) as? PlayListCell else { preconditionFailure() }
                guard let playList = item as? PlayList else { return nil }
                cell.image.image = playList.image
                print(playList)
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    // 헤더뷰 생성
    private func header() {
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            // kind가 맞는지 체크
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            switch indexPath.section {
            case 0:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
                view?.label.text = "새로운 아티스트"
                view?.button.setTitle("더보기", for: .normal)
                return view
                
            case 1:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
                view?.label.text = "현재 음악 순위"
                view?.button.setTitle("더보기", for: .normal)
                return view
                
            case 2:
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? HeaderView
                view?.label.text = "추천 플레이리스트"
                view?.button.setTitle("더보기", for: .normal)
                return view
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    private func makeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.Artist, .Music, .Playlist])
        snapshot.appendItems(newArtist, toSection: Section.Artist)
        snapshot.appendItems(musicDetail, toSection: Section.Music)
        snapshot.appendItems(playList, toSection: Section.Playlist)
        dataSource.apply(snapshot)
    }
    
    private func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        return UICollectionViewCompositionalLayout(sectionProvider: { sectionNumber, env in

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
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                //        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(400))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 5)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                //        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                section.interGroupSpacing = 5
                return section
                
            } else if sectionNumber == 2 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1)))
                //        item.contentInsets = .init(top: 0, leading: 5, bottom: 16, trailing: 5)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.8)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 30
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)]
                return section
            } else {
                return nil
            }
        }, configuration: config)
    }
}

