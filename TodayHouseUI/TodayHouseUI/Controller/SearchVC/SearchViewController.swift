//
//  SearchViewController.swift
//  TodayHouseUI
//
//  Created by 김지수 on 2022/11/01.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let dataManager = DataManager()
    private var dataList: [String] = []
    private var vcList: [UIViewController] = []
    private var recommandData: [RecommandSearchKeyword] = []
    private var currentPage: Int = 0 {
        didSet {
            pagingAction(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    private var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = #colorLiteral(red: 0.2151565254, green: 0.7715450525, blue: 0.9392927885, alpha: 1)
        return button
    }()
    
    private var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.searchBarStyle = .minimal
        sb.searchTextField.font = UIFont.systemFont(ofSize: 15, weight: .light)
        sb.placeholder = "검색어를 입력해주세요"
        return sb
    }()
    
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    private var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return vc
    }()
    
    private var line: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
        addSubView()
        setupHeaderView()
        setupCollectionView()
        setupPageViewController()
        setupLine()
        setupDelegate()
        currentPage = 0
    }
    
    // VC 생성 ! 🔥
    private func setupVC() {
        // Data Fetch
        self.dataList = dataManager.getCategoryData()
        self.recommandData = dataManager.getRkData()
        
        // Data 분기
        let photoData = self.recommandData.filter { data in
            data.type == .photo
        }
        let houseWarmData = self.recommandData.filter { data in
            data.type == .houseWarming
        }
        let knowHowData = self.recommandData.filter { data in
            data.type == .knowHow
        }
        
        // VC 생성
        let firstVC = FirstSubViewController()
        let secondVC = RecommandKeywordViewController(dataModel: photoData)
        let thirdVC = RecommandKeywordViewController(dataModel: houseWarmData)
        let fourthVC = RecommandKeywordViewController(dataModel: knowHowData)
        let fifthVC: UIViewController = {
            let vc = UIViewController()
            let label = UILabel()
            label.text = "Sample"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 50, weight: .bold)
            vc.view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor),
                label.heightAnchor.constraint(equalToConstant: 100),
                label.widthAnchor.constraint(equalToConstant: 500)
            ])
            return vc
        }()
        
        vcList = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        
        dataList.forEach { data in
            let vc = UIViewController()
            let label = UILabel()
            label.text = "\(data)"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 50, weight: .bold)
            vc.view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor),
                label.heightAnchor.constraint(equalToConstant: 100),
                label.widthAnchor.constraint(equalToConstant: 500)
            ])
            vcList += [vc]
        }
        dump(vcList)
    }
    
    private func addSubView() {
        view.addSubview(headerView)
        headerView.addSubview(collectionView)
        headerView.addSubview(searchBar)
        headerView.addSubview(backButton)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(line)
        view.backgroundColor = .white
    }
    
    private func setupHeaderView() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 80),
            
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            backButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 1.0),
            
            searchBar.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            searchBar.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 3),
            searchBar.bottomAnchor.constraint(equalTo: backButton.bottomAnchor, constant: -3),
            
            searchBar.searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            searchBar.searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            searchBar.searchTextField.topAnchor.constraint(equalTo: searchBar.topAnchor),
            searchBar.searchTextField.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.register(SearchCategoryCell.self, forCellWithReuseIdentifier: "SearchCategoryCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private func setupPageViewController() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        let firstVC = vcList.first
        pageViewController.setViewControllers([firstVC!], direction: .forward, animated: true)
    }
    
    private func setupLine() {
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            line.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            line.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    private func pagingAction(oldValue: Int, newValue: Int) {
        let action: UIPageViewController.NavigationDirection = {
            if oldValue < newValue {
                return .forward
            } else {
                return .reverse
            }
        }()
        pageViewController.setViewControllers([vcList[newValue]], direction: action, animated: true, completion: nil)
        collectionView.selectItem(at: IndexPath(item: newValue, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // BackButton 클릭시 액션
    @objc private func backButtonTapped(sender: UIButton!) {
        self.dismiss(animated: true)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCell", for: indexPath) as? SearchCategoryCell else { return UICollectionViewCell()}
        cell.label.text = dataList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentPage = indexPath.row
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dataList[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width + 20, height: collectionView.bounds.height)
    }
}

extension SearchViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = vcList.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return vcList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = vcList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == vcList.count {
            return nil
        }
        return vcList[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = vcList.firstIndex(of: currentVC) else { return }
        currentPage = currentIndex
    }
}
