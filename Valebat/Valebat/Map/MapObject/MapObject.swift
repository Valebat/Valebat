//
//  MapObject.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

import SpriteKit

protocol MapObject {
    var type: MapObjectEnum { get }

    var position: CGPoint { get }
    var xDimension: Double { get }
    var yDimension: Double { get }

    var collidable: Bool { get }
}
