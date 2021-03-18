//
//  CollisionHandler.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import Foundation

enum CollisionType: UInt32, CaseIterable {
    case player = 0b0000001
    case playerAttack = 0b0000010
    case enemy = 0b00000100
    case enemyAttack = 0b00001000
    case wall = 0b00010000

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
            return enemyAttack.rawValue + wall.rawValue
        case .enemy:
            return playerAttack.rawValue + wall.rawValue
        case .playerAttack:
            return wall.rawValue + enemy.rawValue
        case .enemyAttack:
            return player.rawValue + wall.rawValue
        case .wall:
            return generateFullMask() - wall.rawValue
        }
    }
}
