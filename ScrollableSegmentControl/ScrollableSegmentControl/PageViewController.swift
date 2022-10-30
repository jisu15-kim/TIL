//
//  PageViewController.swift
//  ScrollableSegmentControl
//
//  Created by 김지수 on 2022/10/29.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var pageViewControllerList = [UIViewController]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createVC()
        
        self.dataSource = self
        self.delegate = self
        print(pageViewControllerList)
        // 첫 페이지를 기본 페이지로 설정
        if let firstVC = pageViewControllerList.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
        title = "부모뷰"
    }
    
    func createVC() {
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.systemIndigo
        
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.purple
        
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.red
        
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.brown
        
        pageViewControllerList.append(vc1)
        pageViewControllerList.append(vc2)
        pageViewControllerList.append(vc3)
        pageViewControllerList.append(vc4)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        
        guard pageViewControllerList.count > previousIndex else { return nil }
        return pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard pageViewControllerList.count != nextIndex else { return nil }
        guard pageViewControllerList.count > nextIndex else { return nil }
        return pageViewControllerList[nextIndex]
    }
}
