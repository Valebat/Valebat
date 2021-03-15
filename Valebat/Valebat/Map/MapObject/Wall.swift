//
//  Wall.swift
//  Valebat
//
//  Created by Jing Lin Shi on 14/3/21.
//

import SpriteKit

class Wall: StaticMapObject {
    let type: MapObjectEnum = MapObjectEnum.wall

    let position: CGPoint
    let xDimension: Double
    let yDimension: Double

    let collidable: Bool

    init(position: CGPoint, scale: Double, collidable: Bool) {
        self.position = position
        self.xDimension = MapObjectConstants.wallDefaultWidth * scale
        self.yDimension = MapObjectConstants.wallDefaultHeight * scale
        self.collidable = collidable
    }

    convenience init(position: CGPoint, collidable: Bool) {
        self.init(position: position, scale: 1.0, collidable: collidable)
    }

    convenience init(position: CGPoint, scale: Double) {
        self.init(position: position, scale: scale, collidable: MapObjectConstants.wallDefaultCollideable)
    }

    convenience init(position: CGPoint) {
        self.init(position: position, scale: 1.0)
    }
}
