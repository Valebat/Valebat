//
//  StaticMapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class StaticMapObject: MapObject {
    let type: MapObjectEnum

    let position: CGPoint
    let xDimension: Double
    let yDimension: Double

    var collidable: Bool

    init(type: MapObjectEnum, position: CGPoint, scale: Double, collidable: Bool) {
        self.type = type
        self.position = position
        self.xDimension = (MapObjectConstants.globalDefaultWidths[type]
                            ?? MapObjectConstants.objectDefaultWidth) * scale
        self.yDimension = (MapObjectConstants.globalDefaultHeights[type]
                            ?? MapObjectConstants.objectDefaultWidth) * scale
        self.collidable = collidable
    }

    convenience init(type: MapObjectEnum, position: CGPoint, collidable: Bool) {
        self.init(type: type, position: position, scale: 1.0, collidable: collidable)
    }

    convenience init(type: MapObjectEnum, position: CGPoint, scale: Double) {
        self.init(type: type, position: position, scale: scale,
                  collidable: MapObjectConstants.objectDefaultCollidable)
        if let collidable =  MapObjectConstants.globalDefaultCollidables[type] {
            self.collidable = collidable
        }
    }

    convenience init(type: MapObjectEnum, position: CGPoint) {
        self.init(type: type, position: position, scale: 1.0)
    }
}
