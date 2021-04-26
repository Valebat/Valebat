//
//  BasicEnemyData.swift
//  Valebat
//
//  Created by Aloysius Lim on 8/4/21.
//

import Foundation
import GameplayKit

struct BasicEnemyData {
    var spriteImage: String = "enemy"
    var startingHP: CGFloat = 10
    var attackDamage: CGFloat = 2
    var enemyType: BasicType = .pure
    var enemyAttackCooldown: TimeInterval = 3
    var enemyMoveSpeed: CGFloat = 30
    var enemyAggroRange: CGFloat = 450
    var enemyAttackRange: CGFloat = 250
    var enemyChaseSpeed: CGFloat = 120
    var attackVelocity: CGFloat = 4
    var deathEXP: Int = 25
}

enum BasicEnemyType: Int {
    case defaultEnemy, waterEnemy, earthEnemy, fireEnemy

    func getEnemyData() -> BasicEnemyData {
        switch self {
        case .defaultEnemy:
            return BasicEnemyData()
        case .waterEnemy:
            return BasicEnemyData(spriteImage: "PixieWater", startingHP: 7, attackDamage: 1.2,
                                  enemyType: .water, enemyAttackCooldown: 1)
        case .earthEnemy:
            return BasicEnemyData(spriteImage: "PixieEarth", startingHP: 15, attackDamage: 3,
                                  enemyType: .earth, enemyAttackCooldown: 5, enemyMoveSpeed: 20,
                                  enemyChaseSpeed: 80, attackVelocity: 2.4)
        case .fireEnemy:
            return BasicEnemyData(spriteImage: "PixieFire", startingHP: 9, attackDamage: 2,
                                  enemyType: .fire, enemyAttackCooldown: 1.3, enemyMoveSpeed: 50,
                                  enemyAggroRange: 500, enemyAttackRange: 300,
                                  enemyChaseSpeed: 150, attackVelocity: 6.7)
        }
    }
}
