//
//  FindCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/29.
//

import UIKit

class FindCell: UITableViewCell {
    
    var find: [Find] = []
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var findCollectionView: UICollectionView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCollectionView()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        findCollectionView?.register(FindCellDetail.self, forCellWithReuseIdentifier: "FindCellDetail")
        titleLabel.text = "카테고리별 상품 찾기"
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        let frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
        self.findCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        contentView.addSubview(self.findCollectionView!)
        contentView.addSubview(self.titleLabel)
        setConstraints()
        
        findCollectionView?.dataSource = self
        findCollectionView?.delegate = self
        findCollectionView?.allowsSelection = false
        findCollectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func setConstraints() {
        self.findCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.findCollectionView!.topAnchor.constraint(equalTo: contentView.topAnchor),
            //            self.findCollectionView!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            self.findCollectionView!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.findCollectionView!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.findCollectionView!.heightAnchor.constraint(equalToConstant: 200),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            self.titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension FindCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = (collectionView.bounds.width - flow.minimumInteritemSpacing * 5) / 4.5
        return CGSize(width: width, height: 120)
    }
}

extension FindCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return find.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = findCollectionView?.dequeueReusableCell(withReuseIdentifier: "FindCellDetail", for: indexPath) as? FindCellDetail else { return UICollectionViewCell() }
        cell.find = find[indexPath.row]
        cell.configure()
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //        switch kind {
    //        case UICollectionView.elementKindSectionHeader:
    //            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
    //            headerView.mainTitleLabel.text = "카테고리별 상품 찾기"
    //            headerView.subTitleLabel.text = ""
    //            return headerView
    //
    //        default:
    //            return UICollectionReusableView()
    //        }
    //    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //        return CGSize(width: findCollectionView!.bounds.width, height: 40)
    //    }
}

extension FindCell: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewCEll
class FindCellDetail: UICollectionViewCell {
    var find: Find?
    
    var image: UIImageView! = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var title: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        return label
    }()
    
    var container: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView() {
        container.addSubview(image)
        contentView.addSubview(container)
        contentView.addSubview(title)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 3),
            image.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 3),
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 3),
            image.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 3),
            
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            container.heightAnchor.constraint(equalToConstant: 20),
            container.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1.0),
            
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 20),
            title.heightAnchor.constraint(equalToConstant: 15),
            
        ])
    }
    
    func configure() {
        guard let data = find else { return }
        print("data : \(data)")
        image.image = data.image
        title.text = data.title
    }
}
