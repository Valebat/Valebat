//
//  MapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SceneKit

protocol MapObject {
    var type: MapObjectEnum { get }
    
    var position: SCNVector3 { get }
    var xDimension: Double { get }
    var yDimension: Double { get }
    
    var collidable: Bool { get }
}
