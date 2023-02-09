//
//  ViewController.swift
//  HelloAR
//
//  Created by 김지수 on 2023/02/08.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 1. 3D Model
        let sphere = MeshResource.generateSphere(radius: 0.05)
        let material = SimpleMaterial(color: .blue, isMetallic: true)
        
        let sphereEntity = ModelEntity(mesh: sphere, materials: [material])
        
        // 2. Create Anchor
        let sphereAnchor = AnchorEntity(world: SIMD3(x: 0, y: 0, z: 0))
        sphereAnchor.addChild(sphereEntity)
        
        // Add Anchor to Scene
        arView.scene.addAnchor(sphereAnchor)
        
//
//        // Load the "Box" scene from the "Experience" Reality File
//        let boxAnchor = try! Experience.loadBox()
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
    }
}
