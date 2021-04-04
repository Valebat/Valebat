//
//  Map.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

class Map {
    private(set) var objects: [MapObject]

    init(withObjects objects: [MapObject]) {
        self.objects = objects
    }

    convenience init() {
        self.init(withObjects: [])
    }

    func addObjects(_ objects: [MapObject]) {
        self.objects.append(contentsOf: objects)
    }

    func convertToMapData() -> MapData {
        return MapData(map: self)
    }
}
