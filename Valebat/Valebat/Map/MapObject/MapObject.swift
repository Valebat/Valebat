//
//  MapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class MapObject {
    var type: MapObjectEnum
    var position: CGPoint
    var xDimension: Double
    var yDimension: Double
    var collidable: Bool

    init(type: MapObjectEnum, position: CGPoint, xDimension: Double, yDimension: Double, collidable: Bool) {
        self.type = type
        self.position = position
        self.xDimension = xDimension
        self.yDimension = yDimension
        self.collidable = collidable
    }
}
