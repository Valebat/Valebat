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

extension MapObject {
    func getPoints() -> [SIMD2<Float>] {
        let points = [SIMD2<Float>(x: Float(self.position.x) - Float(self.xDimension / 2),
                                   y: Float(self.position.y) - Float(self.yDimension / 2)),
                      SIMD2<Float>(x: Float(self.position.x) + Float(self.xDimension / 2),
                                   y: Float(self.position.y) - Float(self.yDimension / 2)),
                      SIMD2<Float>(x: Float(self.position.x) + Float(self.xDimension / 2),
                                   y: Float(self.position.y) + Float(self.yDimension / 2)),
                      SIMD2<Float>(x: Float(self.position.x) - Float(self.xDimension / 2),
                                   y: Float(self.position.y) + Float(self.yDimension / 2))]
        return points
    }

    func convertToMapObjectData() -> MapObjectData {
        return MapObjectData(mapObject: self)
    }
}

class GenericMapObject: MapObject {
    var type: MapObjectEnum
    var position: CGPoint
    var xDimension: Double
    var yDimension: Double
    var collidable: Bool

    init(type: MapObjectEnum, position: CGPoint, xDimension: Double, yDimension: Double, collidable: Bool) {
        self.type = type
        self.position = position
        self.xDimension = xDimension
        self.yDimension = yDimension
        self.collidable = collidable
    }
}
