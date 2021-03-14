//
//  Rock.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class Rock: StaticMapObject {
    let type: MapObjectEnum = MapObjectEnum.rock

    let position: CGPoint
    let xDimension: Double
    let yDimension: Double

    let collidable: Bool

    init(position: CGPoint, scale: Double, collidable: Bool) {
        self.position = position
        self.xDimension = MapObjectConstants.rockDefaultWidth * scale
        self.yDimension = MapObjectConstants.rockDefaultHeight * scale
        self.collidable = collidable
    }

    convenience init(position: CGPoint, collidable: Bool) {
        self.init(position: position, scale: 1.0, collidable: collidable)
    }

    convenience init(position: CGPoint, scale: Double) {
        self.init(position: position, scale: scale, collidable: MapObjectConstants.rockDefaultCollideable)
    }

    convenience init(position: CGPoint) {
        self.init(position: position, scale: 1.0)
    }
}
