//
//  ViewController.swift
//  CMMotionExample
//
//  Created by 김지수 on 2023/05/03.
//

import UIKit
import SnapKit
import CoreMotion

class ViewController: UIViewController {
    
    //MARK: - Properties
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("👉 시작 및 초기화", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var yawLabel = getDebugLabel("yaw")
    lazy var rollLabel = getDebugLabel("roll")
    lazy var pitchLabel = getDebugLabel("pitch")
    
    lazy var unityXLabel = getDebugLabel("Unity X")
    lazy var unityYLabel = getDebugLabel("Unity Y")
    lazy var unityZLabel = getDebugLabel("Unity Z")
    
    let motionManager = CMMotionManager()
    let networkManager = NetworkManager()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.receiveData()
        setupUI()
    }
    
    //MARK: - Selector
    @objc func resetButtonTapped() {
        
        motionManager.stopDeviceMotionUpdates()
        
        let isPortrait = false
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            self.motionManager.startDeviceMotionUpdates(using: .xArbitraryCorrectedZVertical, to: OperationQueue.current!) { [weak self] (motion, error) in
                
                guard let motion = motion else { return }
                let attitude = motion.attitude
                
                let yaw = attitude.yaw
                let pitch = isPortrait ? attitude.pitch : attitude.roll
                let roll = isPortrait ? attitude.roll : -attitude.pitch
                
                let quaternion = Quaternion(x: attitude.quaternion.x,
                                            y: attitude.quaternion.y,
                                            z: attitude.quaternion.z,
                                            w: attitude.quaternion.w)
                
                
                
                // Unity 변환
                self?.getUnityRotation(yaw: yaw, roll: roll, pitch: pitch, handler: { x, y, z in
                    let eulerRotation = EulerRotation(x: x, y: y, z: z)
                    self?.showUnityRotaionResult(eulerRotation)
                    self?.showResult(yaw, pitch, roll)
                    
                    // 네트워크
                    let motionModel = MotionModel(eulerRotation: eulerRotation, quaternion: quaternion)
                    self?.networkManager.startSendData(data: motionModel)
                })
            }
        }
    }
    
    //MARK: - Methods
    func setupUI() {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.width.equalTo(250)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
        
        let debugStack = UIStackView(arrangedSubviews: [yawLabel, rollLabel, pitchLabel, unityXLabel, unityYLabel, unityZLabel])
        debugStack.axis = .vertical
        debugStack.spacing = 10
        
        view.addSubview(debugStack)
        debugStack.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(150)
        }
    }
    
    func getDebugLabel(_ axis: String) -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "\(axis): 0"
        
        return label
    }
    
    func showResult(_ yaw: Double, _ roll: Double, _ pitch: Double) {
        DispatchQueue.main.async { [weak self] in
            self?.yawLabel.text = "yaw: \((yaw * 100).rounded() / 100)"
            self?.rollLabel.text = "roll: \((roll * 100).rounded() / 100)"
            self?.pitchLabel.text = "pitch: \((pitch * 100).rounded() / 100)"
        }
    }
    
    func showUnityRotaionResult(_ eulerRotation: EulerRotation) {
        DispatchQueue.main.async { [weak self] in
            self?.unityXLabel.text = "Unity X: \(eulerRotation.x)"
            self?.unityYLabel.text = "Unity Y: \(eulerRotation.y)"
            self?.unityZLabel.text = "Unity Z: \(eulerRotation.z)"
        }
    }
    
    func getUnityRotation(yaw: Double, roll: Double, pitch: Double, handler: (_ x: Double, _ y: Double, _ z: Double) -> Void) {
        // Degree를 Radian으로 변환합니다.

        let unityX = convertXAngle(oldX: pitch * -57.2958)
        let unityY = yaw * -57.2958
        let unityZ = (-roll * 120.0) / 2
        
        let convertedX = (unityX * 100).rounded() / 100
        let convertedY = (unityY * 100).rounded() / 100
        let convertedZ = (unityZ * 100).rounded() / 100
        
        handler(convertedX, convertedY, convertedZ)
    }
    
    func convertXAngle(oldX: Double) -> Double {
        var newAngle = oldX - 90.0 // 90을 뺌으로써 기준점을 0으로 변경
        if newAngle < -180.0 {
            newAngle += 360.0 // -180보다 작은 경우 360을  더해주어 -180~180 범위로 변경
        } else if newAngle > 180.0 {
            newAngle -= 360.0 // 180보다 큰 경우 360을 빼주어 -180~180 범위로 변경
        }
        return -newAngle
    }
}

