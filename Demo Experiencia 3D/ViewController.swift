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
    var sceneMap = SCNScene(named: "art.scnassets/mundoMapa.scn")
    var lava = SCNScene(named: "art.scnassets/bloqueLava2.scn")?.rootNode.childNodes[0]
    var musicaJump = try? AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "jump", ofType: "mp3")!))
    
    
    
    var blocks = [SCNNode]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
       var sceneBackEnd = self.viewScene as! SCNView
       
        sceneBackEnd.backgroundColor = UIColor.black
        for childNode in (sceneMap?.rootNode.childNodes)!{
          childNode.opacity = 0.5
            
            
        }
        
        sceneBackEnd.scene = sceneMap
        
        sceneBackEnd.showsStatistics = true
        sceneBackEnd.allowsCameraControl = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        sceneBackEnd.addGestureRecognizer(tapGesture)
        
    }

    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        
       
        let scnView = self.viewScene as! SCNView
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        
        if hitResults.count > 0 {
            
            var result = hitResults[0]
            result.node.opacity = 1
       
            if (result.node.name == "plane"){
            var tempLata = lava?.clone()
            
            tempLata?.position = result.node.position
            
            SCNTransaction.animationDuration = 1
            tempLata?.scale = SCNVector3(0.05, 0.05, 0.05)
            tempLata?.scale = SCNVector3(0.1, 0.1, 0.1)
            scnView.scene?.rootNode.replaceChildNode(result.node, with: tempLata!)
            tempLata?.scale = SCNVector3(0.05, 0.05, 0.05)
            musicaJump?.play()
            SCNTransaction.commit()
            }



        }
    }
    
    
    
    @IBAction func removePlanes(_ sender: UIButton) {
        
        var sceneBackEnd = self.viewScene as! SCNView
         var scen = sceneBackEnd.scene
        //sceneBackEnd.backgroundColor = UIColor.blue
        for childNode in (sceneMap?.rootNode.childNodes)!{
            
            if(childNode.name != "plane"){
                blocks.append(childNode)
            }else{
                SCNTransaction.animationDuration = 10
                childNode.position.y = -1
                
                 SCNTransaction.commit()
            }
            
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
        sceneBackEnd.scene?.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
            
            for newChilder in self.blocks {
                sceneBackEnd.scene?.rootNode.addChildNode(newChilder)
            }
        }
        
        
    }
    

}

