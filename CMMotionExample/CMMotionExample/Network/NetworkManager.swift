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
    
    //MARK: - Methods
    func startSendData(data: MotionModel) {
        
        let jsonData = try! JSONEncoder().encode(data)

        // 소켓 생성
        let socket = try! Socket.create(family: .inet, type: .datagram, proto: .udp)

        // UDP 주소 생성 (전송할 호스트와 포트 번호를 설정)
        let address = Socket.createAddress(for: "192.168.0.33", on: 3333)

        // 데이터 전송
        if let bytesSent = try? socket.write(from: jsonData, to: address!) {
            print("Sent \(bytesSent) bytes")
        } else {
            print("데이터 전송 오류")
        }
    }
    
    func receiveData() {
        DispatchQueue.global().async {
            let port: Int32 = 3333 // 원하는 포트 번호를 설정하세요.

            do {
                // UDP 소켓 생성
                let socket = try Socket.create(family: .inet, type: .datagram, proto: .udp)

                // 주소와 포트를 바인딩
                try socket.listen(on: Int(port))

                print("UDP 소켓이 포트 \(port)에서 수신을 대기하고 있습니다.")

                // 데이터 수신
                var data = Data(capacity: 4096)
                let (bytesRead, address) = try socket.readDatagram(into: &data)

                print("데이터 수신: \(data) \(bytesRead) 바이트")
//                print("발신 주소: \(address?.description ?? "")")

                // 소켓 닫기
//                socket.close()
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
}
