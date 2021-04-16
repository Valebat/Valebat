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
class HealthComponent: BaseComponent {

    var damageTakenObservers = [ObjectIdentifier: DamageTakenObserver]()
    var fullHealth: CGFloat
    var currentHealth: CGFloat

    init(health: CGFloat) {
        self.fullHealth = health
        self.currentHealth = health
        super.init()
    }

    func takeDamage(damage: CGFloat) {
        currentHealth = max(currentHealth - damage, 0)
        damageTakenObservers.values
            .forEach({ $0.onDamageTaken(damageAmount: damage,
                                        currentHealth: currentHealth,
                                        maximumHealth: fullHealth )})
        if currentHealth == 0 {
            entity?.component(conformingTo: DeathComponent.self)?.onDeath()
        }
    }

    func healDamage(_ damage: CGFloat) {
        currentHealth = min(currentHealth + damage, fullHealth)
        damageTakenObservers.values
            .forEach({ $0.onDamageTaken(damageAmount: damage,
                                        currentHealth: currentHealth,
                                        maximumHealth: fullHealth )})
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
