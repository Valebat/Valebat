//
//  MapObjectUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 5/4/21.
//

import Foundation

class MapObjectUtil {
    static func getBoundingBoxOfMapObject(_ object: MapObject) -> [SIMD2<Float>] {
        let points = [SIMD2<Float>(x: Float(object.position.x) - Float(object.xDimension / 2),
                                   y: Float(object.position.y) - Float(object.yDimension / 2)),
                      SIMD2<Float>(x: Float(object.position.x) + Float(object.xDimension / 2),
                                   y: Float(object.position.y) - Float(object.yDimension / 2)),
                      SIMD2<Float>(x: Float(object.position.x) + Float(object.xDimension / 2),
                                   y: Float(object.position.y) + Float(object.yDimension / 2)),
                      SIMD2<Float>(x: Float(object.position.x) - Float(object.xDimension / 2),
                                   y: Float(object.position.y) + Float(object.yDimension / 2))]
        return points
    }
}
