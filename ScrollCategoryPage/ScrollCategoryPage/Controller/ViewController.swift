//
//  ViewController.swift
//  ScrollCategoryPage
//
//  Created by 김지수 on 2022/10/31.
//

import UIKit

final class ViewController: UIViewController {
    
    private var dataList: [String] = []
    private var vcList: [UIViewController] = []
    private var currentPage: Int = 0 {
        didSet {
            pagingAction(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
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
        
        fetchData()
        setupVC()
        addSubView()
        setupCollectionView()
        setupPageViewController()
        setupLine()
        setupDelegate()
        currentPage = 0
    }
    
    private func fetchData() {
        dataList = ["통합", "사진", "집들이", "노하우", "Q&A", "시공업체", "유저", "전자기기", "책상"]
    }
    
    private func setupVC() {
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
    
    private func setupCollectionView() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.heightAnchor.constraint(equalToConstant: 50)
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
    
    private func addSubView() {
        view.addSubview(collectionView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(line)
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
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell()}
        cell.label.text = dataList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.currentPage = indexPath.row
    }
}

extension ViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
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
