//
//  MapObjectConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 11/3/21.
//

class MapObjectConstants {
    static let objectDefaultHeight: Double = Double(ViewConstants.gridSize)
    static let objectDefaultWidth: Double = Double(ViewConstants.gridSize)
    static let objectDefaultCollidable: Bool = true

    /// Nothing can spawn with 1 radius of this object.
    /// Only guaranteed spawns can be protected.
    static let protectedSpawns: [MapObjectEnum] = [.spawner]

    static let globalDefaultHeights: [MapObjectEnum: Double] = [.wall: objectDefaultHeight,
                                                                 .rock: objectDefaultHeight,
                                                                 .crate: objectDefaultHeight,
                                                                 .spawner: objectDefaultHeight,
                                                                 .stairs: objectDefaultHeight]
    static let globalDefaultWidths: [MapObjectEnum: Double] = [.wall: objectDefaultWidth,
                                                                .rock: objectDefaultWidth,
                                                                .crate: objectDefaultWidth,
                                                                .spawner: objectDefaultWidth,
                                                                .stairs: objectDefaultWidth]
    static let globalDefaultCollidables: [MapObjectEnum: Bool] = [.wall: true,
                                                                   .rock: true,
                                                                   .crate: true,
                                                                   .spawner: false,
                                                                   .stairs: false]

    static let intangibleObjects: [MapObjectEnum] = [.powerupSpawner]
}
