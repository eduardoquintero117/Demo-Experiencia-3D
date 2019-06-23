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
    var myScene = SCNScene(named: "art.scnassets/newMundo.scn")
    var video = AVPlayer(url: URL(fileURLWithPath: ((Bundle.main.path(forResource: "Twin Star Exorcist - Opening 4  Kanadeai", ofType: ".mp4") ?? nil)!)))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var scnView = self.viewScene as! SCNView
        
        scnView.scene = myScene
        
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
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
        let pointView = gestureRecognize.location(in: scnView)
        // ---
        let hitResults = scnView.hitTest(pointView, options: [:])
        //print(hitResults)
        
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            SCNTransaction.animationDuration = 0.05
            
            if(result.node.name == "plane"){
                var trash = basuras(number: 7, radius: 0.0)
                for i in trash{
                    scnView.scene?.rootNode.addChildNode(i)
                    
                }
                
            }
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.blue
            
            SCNTransaction.commit()
        }
   
    }


}

