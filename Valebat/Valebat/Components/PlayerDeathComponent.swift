//
//  EnemyDeathComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import GameplayKit
class PlayerDeathComponent: DeathComponent {
    override func onDeath() {
        super.onDeath()
        baseEntity?.entityManager?.playerDied()
    }
}
