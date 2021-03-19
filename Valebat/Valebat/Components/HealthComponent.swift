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

class HealthComponent: GKComponent {

    var armor: DamageMultipliers
    let fullHealth: CGFloat
    var health: CGFloat
    let healthBarFullWidth: CGFloat
    let healthBar: SKShapeNode
    let entityManager = EntityManager.getInstance()

    init(parentNode: SKNode, barWidth: CGFloat,
         barOffset: CGFloat, health: CGFloat) {
        armor = DamageMultipliers()
        self.fullHealth = health
        self.health = health

        healthBarFullWidth = barWidth
        healthBar = SKShapeNode(rectOf:
          CGSize(width: healthBarFullWidth, height: 5), cornerRadius: 1)
        healthBar.fillColor = UIColor.green
        healthBar.strokeColor = UIColor.green
        healthBar.position = CGPoint(x: 0, y: barOffset)
        parentNode.addChild(healthBar)

        healthBar.isHidden = true
        super.init()
    }

    func takeDamage(damages: [DamageType: CGFloat]) {
        takeDamage(armor.getFinalDamage(damages: damages))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @discardableResult func takeDamage(_ damage: CGFloat) -> Bool {
        health = max(health - damage, 0)

        healthBar.isHidden = false
        let healthScale = health/fullHealth
        let scaleAction = SKAction.scaleX(to: healthScale, duration: 0.5)
        healthBar.run(SKAction.group([scaleAction]))

        if health == 0 {
            entity?.component(ofType: DeathComponent.self)?.onDeath()
        }
        return health == 0
    }
}
