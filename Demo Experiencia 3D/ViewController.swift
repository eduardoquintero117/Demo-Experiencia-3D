//
//  ViewController.swift
//  Demo Experiencia 3D
//
//  Created by Eduardo Quintero on 6/16/19.
//  Copyright © 2019 Eduardo Quintero. All rights reserved.
//

import UIKit
import SceneKit
import QuartzCore
import SpriteKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var viewScene: SCNView!
    var myScene = SCNScene(named: "art.scnassets/mundo.scn")
    let video = AVPlayer(url: URL(fileURLWithPath: (Bundle.main.path(forResource: "Twin Star Exorcist - Opening 4  Kanadeai", ofType: ".mp4") ?? nil)!))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var scnView = self.viewScene as! SCNView
      
        
        
    }


}

