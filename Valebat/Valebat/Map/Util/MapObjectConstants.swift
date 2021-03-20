//
//  MapObjectConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

class MapObjectConstants {
    static let objectDefaultHeight: Double = Double(ViewConstants.gridSize)
    static let objectDefaultWidth: Double = Double(ViewConstants.gridSize)
    static let objectDefaultCollideable: Bool = true

    static let globalObjectSpawnChance: Int = 5
    static let globalSpawnChances: [MapObjectEnum: Int] = [.wall: 0,
                                                           .rock: 5,
                                                           .crate: 3 ]

    static let globalGuaranteedSpawns: [MapObjectEnum: Int] = [.spawner: 2]

    static let globalDefaultHeights: [MapObjectEnum: Double] = [.wall: objectDefaultHeight,
                                                                 .rock: objectDefaultHeight,
                                                                 .crate: objectDefaultHeight,
                                                                 .spawner: objectDefaultHeight]
    static let globalDefaultWidths: [MapObjectEnum: Double] = [.wall: objectDefaultWidth,
                                                                .rock: objectDefaultWidth,
                                                                .crate: objectDefaultWidth,
                                                                .spawner: objectDefaultWidth]
    static let globalDefaultCollideables: [MapObjectEnum: Bool] = [.wall: true,
                                                                   .rock: true,
                                                                   .crate: true,
                                                                   .spawner: false]

    static let defaultSpawnTime: Double = 7.0
}
