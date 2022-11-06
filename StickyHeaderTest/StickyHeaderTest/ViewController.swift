//
//  ViewController.swift
//  StickyHeaderTest
//
//  Created by 김지수 on 2022/11/05.
//

import UIKit

class ViewController: UIViewController {
    
    let maxHeight: CGFloat = 250.0 //headerView의 최대 높이값
    let minHeight: CGFloat = 50.0 //headerVIew의 최소 높이값
    
    var collectionView: UICollectionView? {
        didSet {
            print("didSet")
            collectionView?.contentInset = UIEdgeInsets(top: maxHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    var heightConstraint: NSLayoutConstraint? {
        didSet {
            heightConstraint?.constant = maxHeight
        }
    }
    
    var dummyData: [Int] = []
    
    let upperHeaderView: UIView = {
        let label = UILabel()
        label.text = "upperHeaderView"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    let lowerHeaderView: UIView = {
        let label = UILabel()
        label.text = "lowerHeaderView"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDummyData()
        setupNavigationBar()
        setupConstraints()
    }
    
    func setupDummyData() {
        for i in 1...100 {
            self.dummyData.append(i)
        }
    }
    
    func setupNavigationBar() {
        title = "Sticky Test"
    }
    
    func setupConstraints() {
        
        self.view.addSubview(headerView)
        headerView.addSubview(upperHeaderView)
        headerView.addSubview(lowerHeaderView)
        
        setupCollectionView()
        
        heightConstraint = headerView.heightAnchor.constraint(equalToConstant: maxHeight)
        heightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            headerView.heightAnchor.constraint(equalToConstant: 250),
            
            upperHeaderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            upperHeaderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            upperHeaderView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            upperHeaderView.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            lowerHeaderView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            lowerHeaderView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            lowerHeaderView.topAnchor.constraint(equalTo: upperHeaderView.bottomAnchor, constant: 10),
            lowerHeaderView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            collectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView!.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        let frame = CGRect(x: view.bounds.width, y: view.bounds.height, width: 0, height: 0)
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        self.view.addSubview(collectionView!)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
//        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        
        collectionView?.register(DummyCell.self, forCellWithReuseIdentifier: "DummyCell")
        collectionView?.showsVerticalScrollIndicator = false
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCell", for: indexPath) as? DummyCell else { return UICollectionViewCell() }
        
        cell.setupUI()
        cell.samplelabel.text = "\(indexPath.row + 1) 번 샘플 셀"
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            heightConstraint!.constant = max(abs(scrollView.contentOffset.y), minHeight)
        } else {
            heightConstraint!.constant = minHeight
        }
        let offset = scrollView.contentOffset.y
        let percentage = -(offset / maxHeight)
        print("% = \(percentage)")
//        upperHeaderView.alpha = percentage
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 40)
    }
}

class DummyCell: UICollectionViewCell {
    let samplelabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupUI() {
        addSubview(samplelabel)
        NSLayoutConstraint.activate([
            samplelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            samplelabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            samplelabel.topAnchor.constraint(equalTo: self.topAnchor),
            samplelabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 0.5
    }
}
