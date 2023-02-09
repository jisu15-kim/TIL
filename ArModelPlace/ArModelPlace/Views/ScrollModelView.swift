//
//  ScrollModelView.swift
//  ArModelPlace
//
//  Created by 김지수 on 2023/02/09.
//

import SwiftUI

struct ScrollModelView: View {
    
    var models: [Model]
    @Binding var selectedModel: Model?
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(models) { item in
                    Button(action: {
                        selectedModel = item
                        print(selectedModel?.modelName)
                    }) {
                        PickerImageView(model: item.image)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }.background(Color.black.opacity(0.5))
    }
}

struct ScrollModelView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollModelView(models: ModelData().models, selectedModel: .constant(ModelData().models[0]))
    }
}
