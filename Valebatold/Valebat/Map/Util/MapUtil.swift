//
//  MapUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SceneKit

class MapUtil {
    static func createNodeFromObject(_ object: MapObject, nodeMap: [MapObjectEnum:SCNNode]) -> SCNNode {
        let optionalNode = nodeMap[object.type]
        assert(optionalNode != nil, "Node for " + object.type.rawValue + " is not in node map!")
        
        let node = optionalNode!.clone()
        node.position = object.position
        
        return node
    }
}
