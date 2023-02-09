//
//  ContentView.swift
//  ArAnimation
//
//  Created by 김지수 on 2023/02/09.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    
    @State private var model = try! Space.load_Space()
    
    var body: some View {
        ZStack {
            ARViewContainer(model: $model)
            VStack {
                Spacer()
                Button(action: {
                    model.notifications.anim.post()
                }, label: {
                    Text("Animation")
                        .font(.title)
                        .foregroundColor(.white)
                })
                .frame(width: 200, height: 50)
                .background(Color.red)
                .cornerRadius(15)
                .padding()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}


struct ARViewContainer: UIViewRepresentable {
    
    @Binding var model: Space._Space // 받기만 하는 것
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Space.load_Space()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(model)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
