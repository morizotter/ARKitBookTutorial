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
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
}

