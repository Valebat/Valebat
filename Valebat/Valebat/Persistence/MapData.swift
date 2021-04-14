//
//  MapData.swift
//  Valebat
//
//  Created by Zhang Yifan on 3/4/21.
//

struct MapData: Codable {

    var mapObjects: [MapObjectData] = []
    var objective: ObjectiveData

    init(map: Map) {
        for object in map.objects {
            mapObjects.append(MapObjectData.convertToMapObjectData(object))
        }
        self.objective = ObjectiveData(objective: map.objective)
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
        if let mapObjective = objective.generateObjective() {
            map.setObjective(mapObjective)
        }

        return map
    }

    static func convertToMapData(_ map: Map) -> MapData {
        return MapData(map: map)
    }
}
