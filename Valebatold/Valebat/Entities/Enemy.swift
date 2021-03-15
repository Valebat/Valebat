//
//  Enemy.swift
//  Valebat
//
//  Created by Aloysius Lim on 12/3/21.
//

import Foundation
import GameplayKit

class Enemy: GKEntity {

    override init() {
        super.init()
        addComponent(Health(startingHP: 100))
        let node = SCNNode()
        let tubeNode = SCNNode(geometry: SCNTube(innerRadius: 0.2, outerRadius: 0.8, height: 5))
        tubeNode.position = SCNVector3(x: 0, y: 4, z: 0)
        let head = SCNNode(geometry: SCNSphere(radius: 2))
        head.position = SCNVector3(0, 2, 0)
        let blue = SCNMaterial()
        blue.diffuse.contents = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        head.geometry?.firstMaterial = blue
        let green = SCNMaterial()
        green.diffuse.contents = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        tubeNode.geometry?.firstMaterial = green
        
        node.addChildNode(tubeNode)
        node.addChildNode(head)
        node.position = SCNVector3(0,0,3)
        addComponent(RenderComponent(node: node))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
