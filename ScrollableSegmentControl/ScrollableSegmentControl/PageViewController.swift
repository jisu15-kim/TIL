//
//  PageViewController.swift
//  ScrollableSegmentControl
//
//  Created by 김지수 on 2022/10/29.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var currentPage: Int = 0
    {
        didSet {
            // 값이 달라진 경우만 작동하도록
            if oldValue != currentPage {
                NotificationCenter.default.post(name: .changeVcIndex, object: self.currentPage)
            }
        }
    }
    
    // 뷰 컨트롤러 생성
    private let vc1: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .systemIndigo
        return vc
    }()
    private let vc2: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        return vc
    }()
    private let vc3: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        return vc
    }()
    private let vc4: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        return vc
    }()
    
    private lazy var pageViewControllerList: [UIViewController] = [vc1, vc2, vc3, vc4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.dataSource = self
        self.delegate = self
        // 첫 페이지를 기본 페이지로 설정
        if let firstVC = pageViewControllerList.first {
            setViewControllers([firstVC], direction: .forward, animated: true)
        }
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(movePage(_:)), name: .changeScIndex, object: nil)
    }
    
    // 페이지 이동
    @objc func movePage(_ data: Notification) {
        if let index = data.object as? Int {
            
            if index < currentPage {
                self.setViewControllers([pageViewControllerList[index]], direction: .reverse, animated: true, completion: nil)
            } else {
                self.setViewControllers([pageViewControllerList[index]], direction: .forward, animated: true, completion: nil)
            }
            self.currentPage = index
        }
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
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let viewControllerIndex = pageViewControllerList.firstIndex(of: pageViewController.viewControllers!.first!)
            self.currentPage = viewControllerIndex!
            print(currentPage)
        } else {
            return
        }
        
    }
}


