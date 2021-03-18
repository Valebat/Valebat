//
//  TestConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class TestConstants {
    static let testMap: Map = Map(withObjects: [
        StaticMapObject(type: .rock, position: CGPoint(x: 150.0, y: 150.0), scale: 2.0),
        StaticMapObject(type: .rock, position: CGPoint(x: 260.0, y: 375.0)),
        StaticMapObject(type: .rock, position: CGPoint(x: 535.0, y: 425.0)),
        StaticMapObject(type: .wall, position: CGPoint(x: 305.0, y: 525.0), scale: 0.5),
        StaticMapObject(type: .wall, position: CGPoint(x: 105.0, y: 425.0))
    ])
}
