//
//  NetworkManager.swift
//  CMMotionExample
//
//  Created by 김지수 on 2023/05/04.
//

import Foundation
import Network
import Socket

class NetworkManager {
    let ip: String = "192.168.0.33"
    let port: Int32 = 3333
    
    //MARK: - Methods
    func startJasonData(data: MotionModel) {
        
        let jsonData = try! JSONEncoder().encode(data)

        // 소켓 생성
        let socket = try! Socket.create(family: .inet, type: .datagram, proto: .udp)

        // UDP 주소 생성 (전송할 호스트와 포트 번호를 설정)
        let address = Socket.createAddress(for: ip, on: port)

        // 데이터 전송
        if let bytesSent = try? socket.write(from: jsonData, to: address!) {
            print("Sent \(bytesSent) bytes")
        } else {
            print("데이터 전송 오류")
        }
    }
    
    func sendBinaryData(motionData: MotionModel) {
        var getMotionData = motionData
        var binaryData = Data()
        let mutableData = withUnsafeMutableBytes(of: &getMotionData) { data in
            Data(data)
        }
        binaryData.append(mutableData)
        
        // 소켓 생성
        let socket = try! Socket.create(family: .inet, type: .datagram, proto: .udp)

        // UDP 주소 생성 (전송할 호스트와 포트 번호를 설정)
        let address = Socket.createAddress(for: ip, on: port)

        // 데이터 전송
        if let _ = try? socket.write(from: binaryData, to: address!) {
//            print("Sent \(dataSend) bytes")
        } else {
            print("데이터 전송 오류")
        }
    }
    
    func receiveData() {
        DispatchQueue.global().async { [weak self] in

            do {
                // UDP 소켓 생성
                let socket = try Socket.create(family: .inet, type: .datagram, proto: .udp)

                // 주소와 포트를 바인딩
                guard let port = self?.port else { return }
                try socket.listen(on: "\(port)")
                print("UDP 소켓이 포트 \(port)에서 수신 대기중.")

                // 데이터 수신
                var buffer = Data(capacity: 1024)
                
                while true {
                    let (_, _) = try! socket.readDatagram(into: &buffer)
                    
                    if let motionModel = self?.binaryDataDecoding(withMotionModelData: buffer) {
                        print("X: \(motionModel.eulerRotation.x), Y: \(motionModel.eulerRotation.y), Z: \(motionModel.eulerRotation.z)")
                    }
                    
                    // 버퍼 초기화
                    buffer.removeAll(keepingCapacity: true)
                }
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    func binaryDataDecoding(withMotionModelData data: Data) -> MotionModel {
        
        /// 1. data의 앞에서 12바이트 가져오기
        /// 2. Float 바이트(4) 만큼 가져오기
        /// 3. .advanced(by: 4) - 4바이트 옆으로 이동한 뒤에 가져오기
        /// 에러처리 해줘야댐
        
        let eulerRotationBytes = data.prefix(12)
        let eulerX = eulerRotationBytes.withUnsafeBytes { $0.load(as: Float.self) }
        let eulerY = eulerRotationBytes.advanced(by: 4).withUnsafeBytes { $0.load(as: Float.self) }
        let eulerZ = eulerRotationBytes.advanced(by: 8).withUnsafeBytes { $0.load(as: Float.self) }
        
        let quaternionBytes = data.suffix(16)
        let quaternionX = quaternionBytes.withUnsafeBytes { $0.load(as: Float.self) }
        let quaternionY = quaternionBytes.advanced(by: 4).withUnsafeBytes { $0.load(as: Float.self) }
        let quaternionZ = quaternionBytes.advanced(by: 8).withUnsafeBytes { $0.load(as: Float.self) }
        let quaternionW = quaternionBytes.advanced(by: 12).withUnsafeBytes { $0.load(as: Float.self) }
        
        let eulerModel = EulerRotation(x: eulerX, y: eulerY, z: eulerZ)
        let quaternionModel = Quaternion(x: quaternionX, y: quaternionY, z: quaternionZ, w: quaternionW)
        
        return MotionModel(eulerRotation: eulerModel, quaternion: quaternionModel)
    }
}
