//
//  MapData.swift
//  Valebat
//
//  Created by Zhang Yifan on 3/4/21.
//

struct MapData: Codable {

    var mapObjects: [MapObjectData] = []

    init(map: Map) {
        for object in map.objects {
            mapObjects.append(MapObjectData.convertToMapObjectData(object))
        }
    }

    func generateMap() -> Map {
        var mapGameObjects: [MapObject] = []
        for dataObject in mapObjects {
            guard let gameObject = dataObject.generateMapObject() else {
                continue
            }
            mapGameObjects.append(gameObject)
        }
        let map = Map()
        map.addObjects(mapGameObjects)
        return map
    }

    static func convertToMapData(_ map: Map) -> MapData {
        return MapData(map: map)
    }
}
