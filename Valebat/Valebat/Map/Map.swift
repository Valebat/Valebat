//
//  Map.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

class Map {
    private(set) var objects: [MapObject]
    private(set) var objective: Objective
    var BGM: MusicTrack?
    init(withObjects objects: [MapObject], withObjective objective: Objective) {
        self.objects = objects
        self.objective = objective

    }

    convenience init() {
        self.init(withObjects: [], withObjective: Objective())
    }

    func addObjects(_ objects: [MapObject]) {
        self.objects.append(contentsOf: objects)
    }

    func setObjective(_ objective: Objective) {
        self.objective = objective
    }
}
