//
//  StaticMapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class StaticMapObject: MapObject {
    init(type: MapObjectEnum, position: CGPoint, scale: Double, collidable: Bool) {
        let xDimension = (MapObjectConstants.globalDefaultWidths[type]
                            ?? MapObjectConstants.objectDefaultWidth) * scale
        let yDimension = (MapObjectConstants.globalDefaultHeights[type]
                            ?? MapObjectConstants.objectDefaultWidth) * scale
        super.init(type: type, position: position,
                   xDimension: xDimension, yDimension: yDimension, collidable: collidable)
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
