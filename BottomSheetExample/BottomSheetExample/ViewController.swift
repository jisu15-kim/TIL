//
//  ViewController.swift
//  BottomSheetExample
//
//  Created by 김지수 on 2023/01/16.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController, FloatingPanelControllerDelegate {
    
    let panel = FloatingPanelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomSheet()
    }
    
    private func setupBottomSheet() {
        panel.delegate = self
    }
    
    
    @IBAction func openButtonTapped(_ sender: UIButton) {
        let vc = PanelViewController()
        vc.panel = panel
        
        // content 뷰 컨트롤러 설정
        panel.set(contentViewController: vc)
        
        // track: 바텀시트의 스크롤뷰와 연동 !
        panel.track(scrollView: vc.tableView)
        panel.layout = CustomFloatingPanelLayout()
        panel.addPanel(toParent: self, animated: true) {
            print("호출됨")
        }
//        panel.show(animated: true) {
//            print("호출됨")
//        }
    }
    
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == FloatingPanelState.full {
            print("full")
            print(fpc.state)
        } else {
            print(fpc.state)
        }
    }
}

// 커스텀 레이아웃
class CustomFloatingPanelLayout: FloatingPanelLayout{
    var position: FloatingPanelPosition = .bottom
    var initialState: FloatingPanelState = .tip
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .superview),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 270.0, edge: .bottom, referenceGuide: .superview),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 110.0, edge: .bottom, referenceGuide: .superview)
            ]
        }
}
