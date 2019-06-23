//
//  FunctionTrasScene.swift
//  Demo Experiencia 3D
//
//  Created by Eduardo Quintero on 6/19/19.
//  Copyright © 2019 Eduardo Quintero. All rights reserved.
//

import Foundation
import SceneKit


func basuras(number: Int, radius: Float) -> [SCNNode] {
        
        var nodesTrash = [SCNNode]()
         guard let scenePath = Bundle.main.path(forResource: "lataX1", ofType: "scn", inDirectory: "art.scnassets") else {
            return  nodesTrash}
        
        let sceneUrl = URL(fileURLWithPath: scenePath)
        let scene = try? SCNScene(url: sceneUrl, options: nil)
        guard var nodeTemp = scene?.rootNode.childNode(withName: "lata", recursively: true) else { return nodesTrash }
        
        for i in 1...number{
            
            nodeTemp.position = SCNVector3(x: 0.0, y: 0.9, z: Float(i) / 10)
            var nodebasura = nodeTemp.clone()
            
            nodesTrash.append(nodebasura)
            
            
        }
        
        print(nodesTrash)
        print("----------")
        print(nodesTrash[0].position)
        print(nodesTrash[1].position)
        print(nodesTrash[4].position)
        return nodesTrash
    }

