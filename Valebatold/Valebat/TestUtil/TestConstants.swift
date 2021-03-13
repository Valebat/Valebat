//
//  TestConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SceneKit

class TestConstants {
    static let TEST_MAP: Map = Map(withObjects: [
        Rock(position: SCNVector3(x: 10.0, y: 0.0, z: 10.0)),
        Rock(position: SCNVector3(x: -10.0, y: 0.0, z: 10.0)),
        Rock(position: SCNVector3(x: 10.0, y: 0.0, z: -10.0)),
        Rock(position: SCNVector3(x: -10.0, y: 0.0, z: -10.0)),
    ])
}
