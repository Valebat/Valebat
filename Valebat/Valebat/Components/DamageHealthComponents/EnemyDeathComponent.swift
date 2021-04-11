//
//  EnemyDeathComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import GameplayKit
class EnemyDeathComponent: DeathComponent {
    var enemyEXP: Int
    init(exp: Int) {
        enemyEXP = exp
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func onDeath() {
        baseEntity?.entityManager?.currentSession?.playerStats.gainEXP(exp: enemyEXP)
        super.onDeath()
    }
}
