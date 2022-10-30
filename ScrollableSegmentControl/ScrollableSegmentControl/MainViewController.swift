//
//  ViewController.swift
//  ScrollableSegmentControl
//
//  Created by 김지수 on 2022/10/29.
//

import UIKit

enum SegmentSection: String, CaseIterable {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
}

class MainViewController: UIViewController {
        
    @IBOutlet weak var segmentController: UISegmentedControl!
    let pageViewController = PageViewController()
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentController()
        
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(segmentValueChange(_:)), name: .changeVcIndex, object: nil)
    }
    
    func setupSegmentController() {
        segmentController.removeAllSegments()
        
        SegmentSection.allCases.enumerated().forEach { (index, section) in
            segmentController.insertSegment(withTitle: section.rawValue, at: index, animated: true)
        }
        segmentController.selectedSegmentIndex = 0
    }
    
    // 세그먼트 컨트롤러의 값 변경
    @objc func segmentValueChange(_ data: Notification) {
        if let index = data.object as? Int {
            segmentController.selectedSegmentIndex = index
            segmentController.sendActions(for: .valueChanged)
        }
    }
    
    // 세그먼트 컨트롤러의 값 변경 트리거 수신
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        NotificationCenter.default.post(name: .changeScIndex, object: index)
    }
}

