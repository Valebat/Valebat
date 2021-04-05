//
//  MapObjectData.swift
//  Valebat
//
//  Created by Zhang Yifan on 3/4/21.
//

import CoreGraphics

struct MapObjectData: Codable {
    var type: String

    var xPosition: Double
    var yPosition: Double
    var xDimension: Double
    var yDimension: Double

    var collidable: Bool

    func generateMapObject() -> MapObject? {
        guard let mapObjectType = MapObjectEnum(rawValue: type) else {
            return nil
        }
        let object = MapObject(type: mapObjectType,
                               position: CGPoint(x: CGFloat(xPosition), y: CGFloat(yPosition)),
                               xDimension: xDimension, yDimension: yDimension,
                               collidable: collidable)
        return object
    }

    init(type: MapObjectEnum, position: CGPoint, xDimension: Double, yDimension: Double, collidable: Bool) {
        self.type = type.rawValue
        self.xPosition = Double(position.x)
        self.yPosition = Double(position.y)
        self.xDimension = xDimension
        self.yDimension = yDimension
        self.collidable = collidable
    }

    init(mapObject: MapObject) {
        self.init(type: mapObject.type, position: mapObject.position,
                  xDimension: mapObject.xDimension, yDimension: mapObject.yDimension, collidable: mapObject.collidable)
    }

    static func convertToMapObjectData(_ mapObject: MapObject) -> MapObjectData {
        return MapObjectData(mapObject: mapObject)
    }
}
