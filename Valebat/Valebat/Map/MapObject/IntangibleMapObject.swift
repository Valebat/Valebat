//
//  IntangibleMapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/4/21.
//

import SpriteKit

class IntangibleMapObject: MapObject {
    let type: MapObjectEnum

    var position: CGPoint = CGPoint.zero
    var xDimension: Double = 0.0
    var yDimension: Double = 0.0
    var collidable: Bool = false

    init(type: MapObjectEnum) {
        self.type = type
    }
}
