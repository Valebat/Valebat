//
//  ViewConstants.swift
//  Valebat
//
//  Created by Jing Lin Shi on 10/3/21.
//

import CoreGraphics

struct ViewConstants {
    static let sceneHeight: CGFloat = 640.0
    static var sceneWidth: CGFloat = 0 // to be set on init
    static var gridSize: CGFloat = 40.0
    static var enemyToGridRatio: CGFloat = 0.75

    static var playerToGridRatio: CGFloat = 1.5
    static let playerWidth: CGFloat = gridSize * playerToGridRatio
    static let playerHeight: CGFloat = gridSize * playerToGridRatio
    static let playerSpawnOffset: CGFloat = 0.5
}
