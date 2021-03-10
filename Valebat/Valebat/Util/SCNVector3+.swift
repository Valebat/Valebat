//
//  SCNVector3+.swift
//  Valebat
//
//  Created by Jing Lin Shi on 10/3/21.
//

import SceneKit

extension SCNVector3 {
    static func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
        return SCNVector3(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }
}
