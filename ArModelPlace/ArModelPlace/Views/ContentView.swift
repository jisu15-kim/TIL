//
//  ContentView.swift
//  ArModelPlace
//
//  Created by 김지수 on 2023/02/09.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @State private var selectedModel: Model?
    
    var modelData = ModelData()
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            ARViewContainer(selectedModel: $selectedModel)
            ScrollModelView(models: modelData.models, selectedModel: $selectedModel)
        }.edgesIgnoringSafeArea(.all)
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
