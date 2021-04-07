//
//  SpawnEnemyUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import SpriteKit

class SpawnEnemyUtil {
    static func spawnEnemyWithType(_ type: EnemyTypeEnum, position: CGPoint) -> BaseEnemyEntity {
        switch type {
        case .enemy:
            return EnemyEntity(position: position)
        case .boss:
            return BossEntity()
        }

    }
}
