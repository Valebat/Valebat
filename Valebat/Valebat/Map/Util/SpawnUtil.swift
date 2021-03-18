//
//  SpawnUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class SpawnUtil {
    private(set) static var totalSpawnChance: Int?

    static func spawnObject(position: CGPoint) -> MapObject? {
        var rand = Int(arc4random() % 255)

        if MapObjectConstants.globalObjectSpawnChance < rand {
            return nil
        }

        if totalSpawnChance == nil {
            calculateTotalSpawnChance()
        }

        rand = Int(arc4random() % UInt32(totalSpawnChance!))

        for (object, chance) in MapObjectConstants.globalSpawnChances {
            rand -= chance
            if rand < 0 {
                return spawnTypedObject(object, position: position)
            }
        }

        return nil
    }

    static func spawnTypedObject(_ type: MapObjectEnum, position: CGPoint) -> MapObject {
        switch type {
        case .wall:
            return Wall(position: position)
        case .rock:
            return Rock(position: position)
        }
    }

    private static func calculateTotalSpawnChance() {
        var sum: Int = 0
        MapObjectConstants.globalSpawnChances.forEach { sum = sum + $1 }
        totalSpawnChance = sum
    }
}
