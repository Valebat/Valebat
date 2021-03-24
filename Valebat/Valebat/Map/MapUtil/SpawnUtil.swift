//
//  SpawnUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class SpawnUtil {
    private(set) static var totalSpawnChance: Int?

    static func spawnObject(positions: [CGPoint], withBiomeType biomeType: BiomeTypeEnum) -> [MapObject] {
        var mapObjects: [MapObject] = []
        var copiedPositions = positions
        let biomeData: BiomeData = BiomeUtil.getBiomeDataFromType(biomeType)

        calculateTotalSpawnChance(biomeData: biomeData)

        var indexesToRemove: [Int] = []
        var guaranteedPositions: [Int] = []

        for (key, value) in biomeData.globalGuaranteedSpawns {
            for _ in 1...value {
                var rand = Int(arc4random()) % copiedPositions.count

                while !isValidPosition(position: copiedPositions[rand]) || guaranteedPositions.contains(rand) {
                    rand = Int(arc4random()) % copiedPositions.count
                }
                guaranteedPositions.append(rand)

                mapObjects.append(spawnTypedObject(key, position: copiedPositions[rand]))

                if MapObjectConstants.protectedSpawns.contains(key) {
                    for xDir in -1...1 {
                        for yDir in -1...1 {
                            let indexToRemove: Int = rand - xDir * (ViewConstants.numGridsAlongY - 1) - yDir
                            if indexToRemove >= 0 && indexToRemove < copiedPositions.count {
                                indexesToRemove.append(indexToRemove)
                            }
                        }
                    }
                } else {
                    indexesToRemove.append(rand)
                }
            }
        }

        indexesToRemove.sort()
        for idx in 0..<indexesToRemove.count {
            copiedPositions.remove(at: indexesToRemove[indexesToRemove.count - 1 - idx])
        }

        for position in copiedPositions {
            if !isValidPosition(position: position) {
                continue
            }

            var rand = Int(arc4random() % 255)

            if biomeData.globalObjectSpawnChance < rand {
                continue
            }

            rand = Int(arc4random() % UInt32(totalSpawnChance!))

            for (object, chance) in biomeData.globalSpawnChances {
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

    static func isValidPosition(position: CGPoint) -> Bool {
        let playerXSpawnPosition = ViewConstants.sceneWidth * ViewConstants.playerSpawnOffset
        let playerYSpawnPosition = ViewConstants.sceneHeight * ViewConstants.playerSpawnOffset

        if abs(Double(position.x) - Double(playerXSpawnPosition)) <
            (MapObjectConstants.objectDefaultWidth + Double(ViewConstants.playerWidth)) / 2 &&
            abs(Double(position.y) - Double(playerYSpawnPosition)) <
                (MapObjectConstants.objectDefaultHeight + Double(ViewConstants.playerHeight)) / 2 {
            return false
        }

        return true
    }

    static func spawnTypedObject(_ type: MapObjectEnum, position: CGPoint) -> MapObject {
        return StaticMapObject(type: type, position: position)
    }

    private static func calculateTotalSpawnChance(biomeData: BiomeData) {
        var sum: Int = 0
        biomeData.globalSpawnChances.forEach { sum = sum + $1 }
        totalSpawnChance = sum
    }
}
