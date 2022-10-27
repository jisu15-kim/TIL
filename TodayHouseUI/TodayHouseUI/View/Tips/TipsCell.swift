//
//  TipsCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/27.
//

import UIKit

class TipsCell: UITableViewCell {
    
    var collectionViewLayout: UICollectionViewFlowLayout?
//    let tipsCollectionView: UICollectionView! = {
//        let flow = UICollectionViewFlowLayout()
//        flow.itemSize = CGSize(width: 100, height: 100)
//        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
//        cv.backgroundColor = .red
//        return cv
//    }()
    var tipsCollectionView: UICollectionView?
    
    var tips: [Tips]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 15
        let frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.tipsCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.tipsCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(self.tipsCollectionView!)
        
        NSLayoutConstraint.activate([
            self.tipsCollectionView!.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.tipsCollectionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.tipsCollectionView!.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            self.tipsCollectionView!.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
//        self.tipsCollectionView?.backgroundColor =

    }
    
    func setupCollectionView() {
        tipsCollectionView!.register(TipsDetailCell.self, forCellWithReuseIdentifier: "TipsDetailCell")
        tipsCollectionView!.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        self.tipsCollectionView?.dataSource = self
        self.tipsCollectionView?.delegate = self
    }
}

extension TipsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = (collectionView.bounds.width - flow.minimumInteritemSpacing) / 2
        return CGSize(width: width, height: width + 50)
    }
}

extension TipsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = tips else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tipsCollectionView?.dequeueReusableCell(withReuseIdentifier: "TipsDetailCell", for: indexPath) as? TipsDetailCell else { return UICollectionViewCell() }
        guard let data = tips else { return UICollectionViewCell() }
        cell.tip = data[indexPath.row]
        cell.configure()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
            headerView.mainTitleLabel.text = "Awsound님 집에 필요한 꿀팁"
            headerView.subTitleLabel.text = "좋아하실 만한 생활 속 비법들을 모았어요 🫡"
            return headerView
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: tipsCollectionView!.bounds.width, height: 80)
    }
}


class TipsDetailCell: UICollectionViewCell {
    
    var tip: Tips?
    
    var tipsImage: UIImageView! = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var descriptionLabel: UILabel! = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        var stack = UIStackView(arrangedSubviews: [tipsImage, descriptionLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 10
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.stackView.addSubview(tipsImage)
        self.stackView.addSubview(descriptionLabel)
        self.contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        descriptionLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tipsImage.heightAnchor.constraint(equalTo: tipsImage.widthAnchor, multiplier: 1.0).isActive = true
    }
    
    func configure() {
        tipsImage.image = tip?.image
        tipsImage.layer.cornerRadius = 10
        tipsImage.clipsToBounds = true
        descriptionLabel.text = tip?.description
        
    }
}
