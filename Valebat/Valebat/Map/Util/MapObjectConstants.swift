//
//  MapObjectConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

class MapObjectConstants {
    static let objectDefaultHeight: Double = Double(ViewConstants.gridSize)
    static let objectDefaultWidth: Double = Double(ViewConstants.gridSize)
    static let globalObjectSpawnChance: Int = 5
    static let globalSpawnChances: [MapObjectEnum: Int] = [.wall: 0,
                                                           .rock: 5]

    // Rock constants.
    static let rockDefaultHeight: Double = objectDefaultHeight
    static let rockDefaultWidth: Double = objectDefaultWidth
    static let rockDefaultCollideable: Bool = true

    // Wall constants.
    static let wallDefaultHeight: Double = objectDefaultHeight
    static let wallDefaultWidth: Double = objectDefaultWidth
    static let wallDefaultCollideable: Bool = true
}
