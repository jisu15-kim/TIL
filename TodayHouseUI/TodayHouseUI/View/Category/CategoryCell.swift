//
//  CategoryCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/23.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var category: [Category]?
    
    private let gridFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        return layout
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: -15))
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCollectionView() {
        categoryCollectionView.register(UINib(nibName: "CategoryDetailCell", bundle: nil), forCellWithReuseIdentifier: "CategoryDetailCell")
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.collectionViewLayout = gridFlowLayout
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.showsVerticalScrollIndicator = false
        collectionViewConstraint()

    }
    
    func collectionViewConstraint() {
        
        self.categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        self.categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        self.categoryCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.categoryCollectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
    }
}

extension CategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = category else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "CategoryDetailCell", for: indexPath) as? CategoryDetailCell else { return UICollectionViewCell() }
        guard let data = category else { return UICollectionViewCell() }
        
        cell.category = data[indexPath.row]
        cell.setupUI()
        cell.configure()
        
        return cell
    }
}

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = (collectionView.bounds.width - flow.minimumInteritemSpacing * 4) / 5

        return CGSize(width: width, height: 90)
    }
}
