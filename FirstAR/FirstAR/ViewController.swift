//
//  ViewController.swift
//  FirstAR
//
//  Created by NAOKI MORITA on 2018/10/07.
//  Copyright © 2018 com.molabo. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.scene = SCNScene(named: "art.scnassets/ship.scn")!
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
}

extension ViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let planeAnchors = anchors as? [ARPlaneAnchor] else { return }
        print("[ar] anchors: \(planeAnchors)")
    }
    
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        print("[ar] update")
    }
    
    func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
        print("[ar] remove")
    }
}

extension ViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { fatalError() }
        
        // 平面ジオメトリを作成
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        geometry.materials.first?.diffuse.contents = UIColor.yellow
        
        let planeNode = SCNNode(geometry: geometry)
        
        // 平面ジオメトリを持つノードをx軸周りに90度回転
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1, 0, 0)
        
        DispatchQueue.main.async {
            // 検出したアンカーに対応するノードに子ノードとして持たせる
            node.addChildNode(planeNode)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        
    }
}
