//
//  MapObjectConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

class MapObjectConstants {
    static let objectDefaultHeight: Double = Double(ViewConstants.gridSize)
    static let objectDefaultWidth: Double = Double(ViewConstants.gridSize)

    // Rock constants.
    static let rockDefaultHeight: Double = objectDefaultHeight
    static let rockDefaultWidth: Double = objectDefaultWidth
    static let rockDefaultCollideable: Bool = true
    static let rockSpawnChance: Int = 5

    // Wall constants.
    static let wallDefaultHeight: Double = objectDefaultHeight
    static let wallDefaultWidth: Double = objectDefaultWidth
    static let wallDefaultCollideable: Bool = true
}
