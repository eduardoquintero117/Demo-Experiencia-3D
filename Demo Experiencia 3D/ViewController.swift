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
    var myScene = SCNScene(named: "art.scnassets/Mundo.scn")
    //let video = AVPlayer(url: URL(fileURLWithPath: (Bundle.main.path(forResource: "Twin Star Exorcist - Opening 4  Kanadeai", ofType: ".mp4") ?? nil)!))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var scnView = self.viewScene as! SCNView
        
        scnView.scene = myScene
        
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.red
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
        
        
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.viewScene as! SCNView
        
        // check what nodes are tapped
        // --- Posicion de pantalla
        let p = gestureRecognize.location(in: scnView)
        //print(p)
        // ---
        let hitResults = scnView.hitTest(p, options: [:])
        print(hitResults)
   
    }


}

