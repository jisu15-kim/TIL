//
//  Model.swift
//  ArModelPlace
//
//  Created by 김지수 on 2023/02/09.
//

import Foundation
import SwiftUI
import RealityKit
import Combine


// foreach에서 순차적으로 loop 가능하도록 하는 identifiable
class Model: Identifiable {
    var id = UUID()
    var modelName: String
    var image: Image {
        Image(modelName)
    }
    
    var modelEntity: ModelEntity?
    var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        cancellable = ModelEntity.loadModelAsync(named: modelName)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print("error발생: \(error)")
            }, receiveValue: { modelEntity in
                self.cancellable?.cancel()
                print("success to load")
                self.modelEntity = modelEntity
                self.modelEntity?.name = modelName
            })
    }
}

class ModelData {
    var models: [Model] = {
        var file = FileManager()
        guard let path = Bundle.main.resourcePath, let files = try? file.contentsOfDirectory(atPath: path) else { return [] }
        
        var modelData = [Model]()
        for item in files where item.hasSuffix("usdz") {
            let imageName = item.replacingOccurrences(of: ".usdz", with: "") // 파일 이름의 확장자를 지움
            let model = Model(modelName: imageName)
            modelData.append(model)
        }
        return modelData
    }()
}
