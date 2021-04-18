//
//  BossAttackComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation

class BossAttackComponent: BaseComponent, OnDeathObservers, MovementCachable {
    func onDeath() {
        attachedSubComponent.forEach({ $0.deathCleanUp() })
    }

    override func didAddToEntity() {
        entity?.component(conformingTo: EnemyDeathComponent.self)?.onDeathObservers[ObjectIdentifier(self)] = self
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        entity?.component(conformingTo: EnemyDeathComponent.self)?.onDeathObservers[ObjectIdentifier(self)] = nil
        super.willRemoveFromEntity()
    }
    var attachedSubComponent = [BossAttackSubComponent]()
    var currentAttackingComponent: BossAttackSubComponent?
    var coolDown = 0.0
    private var cachedSpriteComponent: SpriteComponent?
    internal var cachedMoveComponent: MoveComponent?
    override init() {
        super.init()
        attachedSubComponent.append(BossBorderOfWaveAndParticle(attachedAttackComponent: self))
        attachedSubComponent.append(BossAttackLaser(attachedAttackComponent: self))
        attachedSubComponent.append(BossAttackRingOfBullets(attachedAttackComponent: self))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func update(deltaTime seconds: TimeInterval) {
        attachedSubComponent.forEach({ $0.update(deltaTime: seconds) })
        coolDown -= seconds
    }

    func launchAttack() {
        if !(currentAttackingComponent?.isCurrentlyCasting ?? false) && coolDown < 0 {
            let randomedIndex = Int.random(in: 0 ... attachedSubComponent.count-1)
            currentAttackingComponent = attachedSubComponent[randomedIndex]
            currentAttackingComponent?.triggerAttack()
            coolDown = currentAttackingComponent?.coolDown ?? 0.0
        }
    }
}
