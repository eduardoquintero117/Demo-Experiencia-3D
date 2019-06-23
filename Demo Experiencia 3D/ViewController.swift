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
    var video = AVPlayer(url: URL(fileURLWithPath: ((Bundle.main.path(forResource: "Twin Star Exorcist - Opening 4  Kanadeai", ofType: ".mp4") ?? nil)!)))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var scnView = self.viewScene as! SCNView
        
        scnView.scene = myScene
        
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.red
        
        //---- video
        
        
        
        
        
        
        let videoNode = SKVideoNode(avPlayer: video)
        
        let skScene = SKScene(size: CGSize(width: 1280, height: 720 ))
        skScene.addChild(videoNode)
        //print(skScene.name)
        //print("--------")
        let planoVideo = scnView.scene?.rootNode.childNode(withName: "planeCine", recursively: true)!
        var mat = SCNMaterial()
        mat.specular.contents = UIColor.white
        mat.isDoubleSided = true
        
        mat.shininess = 1
        mat.diffuse.contents = skScene
        
        planoVideo?.geometry?.materials = [mat]
        //videoNode.play()
        videoNode.size.width = 1288
        videoNode.size.height = 720 / 2
        
        videoNode.position = CGPoint(x: 1288 / 2, y: 720 / 2)
        
        
        //-----
        
        
        
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
            
            if(result.node.name == "Play"){
                video.play()
                video.playImmediately(atRate: 1.0)
                
            }
            
            if(result.node.name == "Pause"){
                
                
                video.pause()
            }
            
            if(result.node.name == "Recargar"){
                //video.playImmediately(atRate: 5.0)
                video.seek(to: CMTime.zero)
            
                
                
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

