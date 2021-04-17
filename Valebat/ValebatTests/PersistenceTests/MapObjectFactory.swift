//
//  MapObjectFactory.swift
//  ValebatTests
//
//  Created by Sreyans Sipani on 18/4/21.
//

import SpriteKit

class MapObjectFactory {

    private init() {}

    static func createMapObject(type: MapObjectEnum, collidable: Bool) -> MapObject {
        let position: CGPoint = CGPoint(x: 0, y: 0)
        return MapObject(type: type, position: position, xDimension: 10,
                         yDimension: 20, collidable: collidable)
    }

    static func createAllMapObjects() -> [MapObject] {
        var mapObjects: [MapObject] = []
        for type in MapObjectEnum.allCases {
            mapObjects.append(createMapObject(type: type, collidable: true))
            mapObjects.append(createMapObject(type: type, collidable: false))
        }
        return mapObjects
    }

    static func equals(lhs: MapObject, rhs: MapObject) -> Bool {
        return lhs.type == rhs.type && lhs.position == rhs.position && lhs.xDimension == rhs.xDimension && lhs.yDimension == rhs.yDimension && lhs.collidable == rhs.collidable
    }
}
