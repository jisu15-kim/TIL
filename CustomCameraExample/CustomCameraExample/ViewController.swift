//
//  ViewController.swift
//  CustomCameraExample
//
//  Created by 김지수 on 2023/05/05.
//

import UIKit
import AVFoundation
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    //MARK: - Properties
    var disposeBag = DisposeBag()
    
    private lazy var captureDevice = AVCaptureDevice.default(for: .video)
    private var session: AVCaptureSession?
    private var output = AVCapturePhotoOutput()
    
    private var cameraPreviewLayer = AVCaptureVideoPreviewLayer()
    
    lazy var previewView: CameraPreviewView = {
        let view = CameraPreviewView()
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    lazy var captureButton = makeActionButtonUI(title: "촬영")
    lazy var flashToggleButton = makeActionButtonUI(title: "플래시")
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        setupCamera()
        setupCameraImportMetadata()
    }
    
    //MARK: - Bind
    func bind() {
        captureButton.rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.output.capturePhoto(with: .init(), delegate: self)
            }.disposed(by: disposeBag)
        
        flashToggleButton.rx.tap
            .bind { [weak self] in
                if let captureDevice = self?.captureDevice, captureDevice.hasTorch {
                    do {
                        try captureDevice.lockForConfiguration()
                        captureDevice.torchMode = captureDevice.torchMode == .off ? .on : .off
                        captureDevice.unlockForConfiguration()
                    } catch {
                        print("Torch could not be used")
                    }
                } else {
                    print("Torch is not available")
                }
            }.disposed(by: disposeBag)
    }
    
    //MARK: - Mothods
    func setupUI() {
        view.addSubview(previewView)
        previewView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(150)
        }
        
        let buttonStack = UIStackView(arrangedSubviews: [flashToggleButton, captureButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 20
        buttonStack.distribution = .fillEqually
        buttonStack.alignment = .fill
        
        view.addSubview(buttonStack)
        buttonStack.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(80)
        }
    }
    
    func makeActionButtonUI(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemIndigo
        button.tintColor = .white
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        return button
    }
    
    func setupCamera() {
        guard let captureDevice = captureDevice else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session = AVCaptureSession()
            session?.sessionPreset = .photo
            session?.addInput(input)
            session?.addOutput(output)
        } catch {
            print(error)
        }
        guard let session = session else { return }
        
        self.previewView.videoPreviewLayer.session = session
        self.previewView.videoPreviewLayer.videoGravity = .resizeAspectFill
        
        DispatchQueue.global().async {
            session.startRunning()
        }
    }
    
    // 메타데이터 처리 함수
    private func setupCameraImportMetadata() {
        let captureMetadataOutput = AVCaptureMetadataOutput()
        guard let session = session else { return }
        if session.canAddOutput(captureMetadataOutput) { session.addOutput(captureMetadataOutput) }
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    }
}

extension ViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print(#function)
        let data = photo.fileDataRepresentation()
    }
}

extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    // MetaData가 들어올 때마다 실행되는 메소드
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        print(#function)
        
        if metadataObjects.count == 0 { return }
    
        // MetaDataObj to Data
        guard let metaDataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
            print("캐스팅 실패")
            return
        }
        
        // 타입은
        print("Metadata Type: \(metaDataObj.type.rawValue)")
        
        if metaDataObj.type == .qr {
            // QR 데이터 해독
            guard let qrCodeStringData = metaDataObj.stringValue else { return }
            print(qrCodeStringData)
        }
    }
}
