//
//  IntangibleMapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/4/21.
//

import SpriteKit

class IntangibleMapObject: MapObject {
    init(type: MapObjectEnum) {
        super.init(type: type, position: CGPoint.zero, xDimension: 0.0, yDimension: 0.0, collidable: false)
    }
}
