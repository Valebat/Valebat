//
//  This file is adapted from:
//
//  HealthComponent.swift
//  DinoDefense
//
//  Created by Toby Stephens on 20/10/2015.
//  Copyright © 2015 razeware. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol DamageTakenObserver {
    func onDamageTaken(damageAmount: CGFloat, currentHealth: CGFloat, maximumHealth: CGFloat)
}
class HealthComponent: GKComponent {

    var armor: DamageMultipliers
    var damageTakenObservers = [ObjectIdentifier: DamageTakenObserver]()
    let fullHealth: CGFloat
    var health: CGFloat
    let entityManager = EntityManager.getInstance()

    init(health: CGFloat) {
        armor = DamageMultipliers()
        self.fullHealth = health
        self.health = health
        super.init()
    }

    func takeDamage(damages: [DamageType: CGFloat]) {
        let damage = armor.getFinalDamage(damages: damages)
        health = max(health - damage, 0)
        damageTakenObservers.values
            .forEach({ $0.onDamageTaken(damageAmount: damage, currentHealth: health, maximumHealth: fullHealth )})
        if health == 0 {
            entity?.component(conformingTo: DeathComponent.self)?.onDeath()
           // entity?.component(ofType: DeathComponent.self)?.onDeath()
           // entity?.component(ofType: EnemyDeathComponent.self)?.onDeath()
        }
    }

    func healDamage(_ damage: CGFloat) {
        health = min(health + damage, fullHealth)
        damageTakenObservers.values
            .forEach({ $0.onDamageTaken(damageAmount: damage, currentHealth: health, maximumHealth: fullHealth )})
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
