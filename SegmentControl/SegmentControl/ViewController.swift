//
//  ViewController.swift
//  SegmentControl
//
//  Created by 김지수 on 2022/10/30.
//

import UIKit

enum SegmentSection: String, CaseIterable {
    case A = "A"
    case B = "B"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSegmentControl()
    }

    private func setupSegmentControl() {
        segmentController.removeAllSegments()
        
        SegmentSection.allCases.enumerated().forEach { (index, section) in
            segmentController.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }
    }
}

