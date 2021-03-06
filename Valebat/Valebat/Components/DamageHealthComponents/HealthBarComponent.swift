//
//  HealthBarComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 21/3/21.
//

import GameplayKit

class HealthBarComponent: BaseComponent, DamageTakenObserver {
    let healthBarFullWidth: CGFloat
    let healthBar: SKShapeNode

    init(barWidth: CGFloat, barOffset: CGFloat) {

        healthBarFullWidth = barWidth
        healthBar = SKShapeNode(rectOf:
          CGSize(width: healthBarFullWidth, height: 5), cornerRadius: 1)
        healthBar.fillColor = UIColor.green
        healthBar.strokeColor = UIColor.green
        healthBar.position = CGPoint(x: 0, y: barOffset)
        healthBar.isHidden = true
        super.init()
    }

    override func didAddToEntity() {
        entity?.component(ofType: SpriteComponent.self)?.node.addChild(healthBar)
        entity?.component(ofType: HealthComponent.self)?.damageTakenObservers[ObjectIdentifier(self)] = self
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        entity?.component(ofType: HealthComponent.self)?
            .damageTakenObservers.removeValue(forKey: ObjectIdentifier(self))
        healthBar.removeFromParent()
        super.willRemoveFromEntity()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onDamageTaken(damageAmount: CGFloat, currentHealth: CGFloat, maximumHealth: CGFloat) {
        healthBar.isHidden = false
        let healthScale = currentHealth/maximumHealth
        let scaleAction = SKAction.scaleX(to: healthScale, duration: 0.5)
        healthBar.run(SKAction.group([scaleAction]))
    }
}
