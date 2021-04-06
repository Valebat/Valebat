//
//  EnemyDeathComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import GameplayKit
class EnemyDeathComponent: DeathComponent {
    override func onDeath() {
        baseEntity?.entityManager?
            .add(EssenceCollectible(type: .fire, amount: 1,
                                    location: entity?.component(ofType: SpriteComponent.self)?.node.position ??
                                        CGPoint(x: 0, y: 0)))
        super.onDeath()
    }
}
