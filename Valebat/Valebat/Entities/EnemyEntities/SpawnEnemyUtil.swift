//
//  SpawnEnemyUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import SpriteKit

class SpawnEnemyUtil {
    static func spawnEnemyWithType(_ type: EnemyTypeEnum, position: CGPoint) -> EnemyProtocol {
        switch type {
        case .enemy:
            let basicType = BasicEnemyType.init(rawValue: Int.random(in: 0 ... 3))!
            return BaseEnemyEntity(enemyData: basicType.getEnemyData(), position: position)
        case .boss:
            return BossEntity()
        }

    }
}
