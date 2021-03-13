//
//  Rock.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class Rock: StaticMapObject {
    let type: MapObjectEnum = MapObjectEnum.ROCK

    let position: CGPoint
    let xDimension: Double
    let yDimension: Double

    let collidable: Bool

    init(position: CGPoint, scale: Double, collidable: Bool) {
        self.position = position
        self.xDimension = MapObjectConstants.ROCKDEFAULTWIDTH
        self.yDimension = MapObjectConstants.ROCKDEFAULTHEIGHT
        self.collidable = collidable
    }

    convenience init(position: CGPoint, collidable: Bool) {
        self.init(position: position, scale: 1.0, collidable: collidable)
    }

    convenience init(position: CGPoint, scale: Double) {
        self.init(position: position, scale: scale, collidable: MapObjectConstants.ROCKDEFAULTCOLLIDABLE)
    }

    convenience init(position: CGPoint) {
        self.init(position: position, scale: 1.0)
    }
}
