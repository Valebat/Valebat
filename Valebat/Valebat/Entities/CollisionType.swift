//
//  CollisionHandler.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import Foundation

enum CollisionType: UInt32, CaseIterable {
    case player = 1
    case playerAttack = 2
    case enemy = 4
    case enemyAttack = 8
    case wall = 16
    case collectible = 32

    static func generateFullMask() -> UInt32 {
        var value: UInt32 = 0
        for type in CollisionType.allCases {
            value += type.rawValue
        }
        return value
    }
    static func generateContactMask(type: CollisionType) -> UInt32 {
        switch type {
        case .player:
            return enemyAttack.rawValue + wall.rawValue + collectible.rawValue
        case .enemy:
            return playerAttack.rawValue + wall.rawValue
        case .playerAttack:
            return wall.rawValue + enemy.rawValue
        case .enemyAttack:
            return player.rawValue + wall.rawValue
        case .wall:
            return generateFullMask() - wall.rawValue
        case .collectible:
            return player.rawValue
        }
    }
}
