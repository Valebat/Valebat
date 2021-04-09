//
//  SpawnUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class SpawnManager {
    private(set) var totalSpawnChance: Int?
    private(set) var biomeData: BiomeData = BiomeData()
    var freePositions: [CGPoint] = []

    func spawnObjects(positions: [CGPoint], withBiomeType biomeType: BiomeTypeEnum) -> [MapObject] {
        var mapObjects: [MapObject] = []
        self.biomeData = BiomeTypeEnum.getBiomeDataFromType(biomeType)

        calculateTotalSpawnChance(biomeData: biomeData)

        let intangibleObjects = handleIntangibleSpawns()
        mapObjects.append(contentsOf: intangibleObjects)

        let (guaranteedObjects, positionsForNormalObjects) = handleGuaranteedSpawns(positions: positions)
        mapObjects.append(contentsOf: guaranteedObjects)

        let (normalObjects, remainingFreePositions) = handleRegularSpawns(positions: positionsForNormalObjects)
        mapObjects.append(contentsOf: normalObjects)
        freePositions = remainingFreePositions

        return mapObjects
    }

    private func handleIntangibleSpawns() -> [MapObject] {
        var mapObjects: [MapObject] = []

        for (key, value) in biomeData.intangibleObjectSpawns {
            if value < 1 {
                continue
            }
            for _ in 1...value {
                mapObjects.append(spawnIntangibleTypedObject(key))
            }
        }

        return mapObjects
    }

    private func handleGuaranteedSpawns(positions: [CGPoint]) -> ([MapObject], [CGPoint]) {
        var copiedPositons = positions
        var mapObjects: [MapObject] = []
        var indexesToRemove: [Int] = []
        var guaranteedPositions: [Int] = []

        for (key, value) in biomeData.globalGuaranteedSpawns {
            if value < 1 {
                continue
            }
            for _ in 1...value {
                var rand = Int(arc4random()) % copiedPositons.count

                while !isValidPosition(position: copiedPositons[rand]) || guaranteedPositions.contains(rand) {
                    rand = Int(arc4random()) % copiedPositons.count
                }
                guaranteedPositions.append(rand)

                mapObjects.append(spawnStaticTypedObject(key, position: copiedPositons[rand]))

                if biomeData.protectedSpawns.contains(key) {
                    for xDir in -1...1 {
                        for yDir in -1...1 {
                            let indexToRemove: Int = rand - xDir * (ViewConstants.numGridsAlongY - 1) - yDir
                            if indexToRemove >= 0 && indexToRemove < copiedPositons.count {
                                indexesToRemove.append(indexToRemove)
                            }
                        }
                    }
                } else {
                    indexesToRemove.append(rand)
                }
            }
        }

        indexesToRemove = Array(Set(indexesToRemove))
        indexesToRemove.sort()
        let count = indexesToRemove.count
        for idx in 0..<indexesToRemove.count {
            copiedPositons.remove(at: indexesToRemove[count - 1 - idx])
        }

        return (mapObjects, copiedPositons)
    }

    private func handleRegularSpawns(positions: [CGPoint]) -> ([MapObject], [CGPoint]) {
        var copiedPositons: [CGPoint] = positions
        var mapObjects: [MapObject] = []
        var indexesToRemove: [Int] = []

        for (index, position) in positions.enumerated() {
            if !isValidPosition(position: position) {
                continue
            }

            var rand = Int(arc4random() % 255)

            if biomeData.globalObjectSpawnChance <= rand {
                continue
            }

            rand = Int(arc4random() % UInt32(totalSpawnChance!))

            for (object, chance) in biomeData.globalSpawnChances {
                rand -= chance
                if rand < 0 {
                    mapObjects.append(spawnStaticTypedObject(object, position: position))
                    indexesToRemove.append(index)
                    break
                }
            }

            continue
        }

        indexesToRemove.sort()
        let count = indexesToRemove.count
        for idx in 0..<indexesToRemove.count {
            copiedPositons.remove(at: indexesToRemove[count - 1 - idx])
        }

        return (mapObjects, copiedPositons)
    }

    private func isValidPosition(position: CGPoint) -> Bool {
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

    private func spawnStaticTypedObject(_ type: MapObjectEnum, position: CGPoint) -> MapObject {
        return StaticMapObject(type: type, position: position)
    }

    private func spawnIntangibleTypedObject(_ type: MapObjectEnum) -> MapObject {
        return IntangibleMapObject(type: type)
    }

    private func calculateTotalSpawnChance(biomeData: BiomeData) {
        var sum: Int = 0
        biomeData.globalSpawnChances.forEach { sum = sum + $1 }
        totalSpawnChance = sum
    }
}
