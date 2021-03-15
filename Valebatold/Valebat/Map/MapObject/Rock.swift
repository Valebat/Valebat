//
//  Rock.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SceneKit

class Rock : StaticMapObject {
    let type: MapObjectEnum = MapObjectEnum.ROCK
    
    let position: SCNVector3
    let xDimension: Double
    let yDimension: Double
    
    let collidable: Bool
    
    init(position: SCNVector3, scale: Double, collidable: Bool) {
        self.position = position
        self.xDimension = MapObjectConstants.ROCK_DEFAULT_WIDTH
        self.yDimension = MapObjectConstants.ROCK_DEFAULT_HEIGHT
        self.collidable = collidable
    }
    
    convenience init(position: SCNVector3, collidable: Bool) {
        self.init(position: position, scale: 1.0, collidable: collidable)
    }
    
    convenience init(position: SCNVector3, scale: Double) {
        self.init(position: position, scale: scale, collidable: MapObjectConstants.ROCK_DEFAULT_COLLIDABLE)
    }
    
    convenience init(position: SCNVector3) {
        self.init(position: position, scale: 1.0)
    }
}
