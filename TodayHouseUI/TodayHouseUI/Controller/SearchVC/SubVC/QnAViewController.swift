//
//  QnAViewController.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/05.
//

import UIKit

class QnAViewController: UIViewController {
    
    var qnaDatas: [QnARecommandModel] = []
    var collectionView: UICollectionView?
    let dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupCollectionView()
        setupConstraints()
    }
    
    func setupData() {
        self.qnaDatas = dataManager.getQnAData()
    }
    
    func setupCollectionView() {
        let layout = CustomFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 35, right: 0)
        layout.sectionHeadersPinToVisibleBounds = true
        
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.isScrollEnabled = true
        self.view.addSubview(collectionView!)
    }
    
    func setupConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
        collectionView.register(QnAViewDetailCell.self, forCellWithReuseIdentifier: "QnAViewDetailCell")
        collectionView.register(QnAHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QnAHeaderView")
    }
}

extension QnAViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let fontSize = CGFloat(14)
        let widthOffset = CGFloat(20)
        let heightOffset = CGFloat(5)
        
        switch indexPath.section {
        case 0:
            let data = qnaDatas.filter { data in
                data.type == .normal }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
                                                            
        case 1:
            let data = qnaDatas.filter { data in
                data.type == .section }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
        case 2:
            let data = qnaDatas.filter { data in
                data.type == .furniture }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
        case 3:
            let data = qnaDatas.filter { data in
                data.type == .space }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
        case 4:
            let data = qnaDatas.filter { data in
                data.type == .wide }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
        case 5:
            let data = qnaDatas.filter { data in
                data.type == .interior }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
        case 6:
            let data = qnaDatas.filter { data in
                data.type == .ect }
            let dummy = data[indexPath.row].title.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)])
            return CGSize(width: dummy.width + widthOffset, height: dummy.height + heightOffset)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
}

extension QnAViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 섹션의 갯수 - Enum 타입의 갯수
        QnARecommandSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            let data = qnaDatas.filter { data in
                data.type == .normal }
            return data.count
        case 1:
            let data = qnaDatas.filter { data in
                data.type == .section }
            return data.count
        case 2:
            let data = qnaDatas.filter { data in
                data.type == .furniture }
            return data.count
        case 3:
            let data = qnaDatas.filter { data in
                data.type == .space }
            return data.count
        case 4:
            let data = qnaDatas.filter { data in
                data.type == .wide }
            return data.count
        case 5:
            let data = qnaDatas.filter { data in
                data.type == .interior }
            return data.count
        case 6:
            let data = qnaDatas.filter { data in
                data.type == .ect }
            return data.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "QnAHeaderView", for: indexPath) as? QnAHeaderView else { return UICollectionReusableView() }
        header.setupUI()
        header.titleLabel.text = QnARecommandSection.allCases[indexPath.section].rawValue
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.collectionView!.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QnAViewDetailCell", for: indexPath) as? QnAViewDetailCell else { return UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            let data = qnaDatas.filter { data in
                data.type == .normal }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        case 1:
            let data = qnaDatas.filter { data in
                data.type == .section }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        case 2:
            let data = qnaDatas.filter { data in
                data.type == .furniture }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        case 3:
            let data = qnaDatas.filter { data in
                data.type == .space }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        case 4:
            let data = qnaDatas.filter { data in
                data.type == .wide }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        case 5:
            let data = qnaDatas.filter { data in
                data.type == .interior }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        case 6:
            let data = qnaDatas.filter { data in
                data.type == .ect }
            cell.setupUI()
            cell.data = data[indexPath.row]
            cell.configure()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

class QnAViewDetailCell: UICollectionViewCell {
    var data: QnARecommandModel?
    
    var viewA: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewB: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var hashMark: UILabel = {
        let label = UILabel()
        label.text = "#"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stack: UIStackView?
    
    func setupUI() {
        self.stack = UIStackView(arrangedSubviews: [viewA, hashMark, titleLabel, viewB])
        self.stack?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack!)
        setupConstraint()
        self.backgroundColor = .systemGray6
    }
    
    func setupConstraint() {
        guard let stack = self.stack else { return }
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.topAnchor.constraint(equalTo: self.topAnchor),
            stack.heightAnchor.constraint(equalToConstant: 20),
            
            viewA.widthAnchor.constraint(equalToConstant: 5),
            viewB.widthAnchor.constraint(equalToConstant: 15),
            hashMark.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func configure() {
        titleLabel.text = data?.title
    }
}

class QnAHeaderView: UICollectionReusableView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
    }
}
