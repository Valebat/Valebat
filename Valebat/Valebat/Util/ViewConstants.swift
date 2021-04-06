//
//  ViewConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 10/3/21.
//

import CoreGraphics

struct ViewConstants {
    static let sceneHeight: CGFloat = 640.0
    static var sceneWidth: CGFloat = 640.0 // to be set on init
    static var gridSize: CGFloat = 40.0
    static var enemyToGridRatio: CGFloat = 0.9

    static var numGridsAlongY: Int = Int(sceneHeight / gridSize)
    static var numGridsAlongX: Int = Int(sceneWidth / gridSize)

    static var playerToGridRatio: CGFloat = 1.5
    static let playerWidth: CGFloat = gridSize * playerToGridRatio
    static let playerHeight: CGFloat = gridSize * playerToGridRatio
    static let playerSpawnOffset: CGFloat = 0.5
    static let bossSpawnOffset: CGFloat = 0.75

    static let baseEnemyEscapeDistance: CGFloat = gridSize / 4

    static let spellVelocityMultiplier: CGFloat = 4
    static let essenceSize: CGFloat = gridSize * 0.9

    static let enemySavedPositions: Int = 40

    static var stairsSensitivity: CGFloat = 0.5
}
