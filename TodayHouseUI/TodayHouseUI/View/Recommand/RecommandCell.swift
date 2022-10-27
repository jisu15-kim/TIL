//
//  RecommandCell.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/10/26.
//

import UIKit

class RecommandCell: UITableViewCell {
    
    @IBOutlet weak var recommandCollectionView: UICollectionView!
    
    var recommandation: [Recommandation]?
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupCollectionView() {
        recommandCollectionView.register(UINib(nibName: "RecommandDetailCell", bundle: nil), forCellWithReuseIdentifier: "RecommandDetailCell")
        recommandCollectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
//        setupConstraint()

        recommandCollectionView.dataSource = self
        recommandCollectionView.delegate = self
    }
    
//    func setupConstraint() {
//        let height = contentView.bounds.width * 2 + 100
//        recommandCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        recommandCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        recommandCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        recommandCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        recommandCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
//    }
}

extension RecommandCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = recommandation else { return 0 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = recommandCollectionView.dequeueReusableCell(withReuseIdentifier: "RecommandDetailCell", for: indexPath) as? RecommandDetailCell else { return UICollectionViewCell() }
        guard let data = recommandation else { return UICollectionViewCell() }
        cell.recommandation = data[indexPath.row]
        cell.configure()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath) as? CollectionHeaderView else { return UICollectionReusableView() }
            headerView.mainTitleLabel.text = "Awsound님을 위한 추천"
            headerView.subTitleLabel.text = "요즘 이런 스타일 좋아하시더라구요 👍"
            return headerView
            
        default:
            return UICollectionReusableView()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: recommandCollectionView.bounds.width, height: 80)
    }
}
extension RecommandCell: UICollectionViewDelegate {
    
}

extension RecommandCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let flow = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let width = (collectionView.bounds.width - flow.minimumInteritemSpacing) / 2
        return CGSize(width: width, height: width + 50)
    }
}
