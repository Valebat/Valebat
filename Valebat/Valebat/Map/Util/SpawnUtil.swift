//
//  SpawnUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class SpawnUtil {
    private(set) static var totalSpawnChance: Int?

    static func spawnObject(positions: [CGPoint]) -> [MapObject] {
        var mapObjects: [MapObject] = []
        var copiedPositions = positions

        if totalSpawnChance == nil {
            calculateTotalSpawnChance()
        }

        for (key, value) in MapObjectConstants.globalGuaranteedSpawns {
            for _ in 1...value {
                let rand = Int(arc4random()) % copiedPositions.count

                mapObjects.append(spawnTypedObject(key, position: positions[rand]))
                copiedPositions.remove(at: rand)
            }
        }

        for position in copiedPositions {
            var rand = Int(arc4random() % 255)

            if MapObjectConstants.globalObjectSpawnChance < rand {
                continue
            }

            rand = Int(arc4random() % UInt32(totalSpawnChance!))

            for (object, chance) in MapObjectConstants.globalSpawnChances {
                rand -= chance
                if rand < 0 {
                    mapObjects.append(spawnTypedObject(object, position: position))
                    break
                }
            }

            continue
        }

        return mapObjects
    }

    static func spawnTypedObject(_ type: MapObjectEnum, position: CGPoint) -> MapObject {
        return StaticMapObject(type: type, position: position)
    }

    private static func calculateTotalSpawnChance() {
        var sum: Int = 0
        MapObjectConstants.globalSpawnChances.forEach { sum = sum + $1 }
        totalSpawnChance = sum
    }
}
