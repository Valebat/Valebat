//
//  TestConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

class TestConstants {
    static let TESTMAP: Map = Map(withObjects: [
        Rock(position: CGPoint(x: 10.0, y: 0.0)),
        Rock(position: CGPoint(x: -10.0, y: 0.0)),
        Rock(position: CGPoint(x: 10.0, y: 0.0)),
        Rock(position: CGPoint(x: -10.0, y: 0.0))
    ])
}
