//
//  HotTopicCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/02.
//

import UIKit

class HotTopicCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var hotData: [IntegratedVcData] = []
    
    var collectionView: UICollectionView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        setupDelegates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        let frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.register(HotTopicDetailCell.self, forCellWithReuseIdentifier: "HotTopicDetailCell")
        collectionView?.register(SearchCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchCollectionHeaderView")
        addSubview(collectionView!)
        setupConstraint()
    }
    
    func setupConstraint() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 15),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func setupDelegates() {
        collectionView!.dataSource = self
        collectionView!.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotData.count
    }
    
    //MARK: - 헤더뷰 데이터
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchCollectionHeaderView", for: indexPath) as? SearchCollectionHeaderView else { return UICollectionReusableView() }
            header.label.text = "인기 검색어"
            header.descriptionLabel.text = "16시 기준"
            header.setupSubView()
            header.setupConstraints()
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    //MARK: - 셀 데이터
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotTopicDetailCell", for: indexPath) as? HotTopicDetailCell else { return UICollectionViewCell() }
        cell.data = hotData[indexPath.row]
        cell.index = indexPath.row + 1
        cell.configure()
        return cell
    }
    
    //MARK: - 헤더뷰 레이아웃
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 40)
    }
    
    //MARK: - 셀 레이아웃
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = (collectionView.bounds.width - flow.minimumInteritemSpacing) / 2
        return CGSize(width: width, height: 40)
    }
}

//MARK: - 셀 클래스
class HotTopicDetailCell: UICollectionViewCell {
    var index: Int?
    var data: IntegratedVcData?
    
    let indexLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "up")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [indexLabel, image, titleLabel])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubView() {
        addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            indexLabel.widthAnchor.constraint(equalToConstant: 20),
            image.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    func configure() {
        indexLabel.text = "\(index!)"
        titleLabel.text = data?.title
        if index == 5 || index == 6 {
            image.image = UIImage(named: "new")
        }
    }
}
