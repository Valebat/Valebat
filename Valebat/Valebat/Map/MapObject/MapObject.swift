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
        let points = [SIMD2<Float>(x: Float(self.position.x),
                                   y: Float(self.position.y)),
                      SIMD2<Float>(x: Float(self.position.x) + Float(self.xDimension),
                                   y: Float(self.position.y)),
                      SIMD2<Float>(x: Float(self.position.x) + Float(self.xDimension),
                                   y: Float(self.position.y) + Float(self.yDimension)),
                      SIMD2<Float>(x: Float(self.position.x),
                                   y: Float(self.position.y) + Float(self.yDimension))]
        return points
    }
}
