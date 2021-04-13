//
//  BossAttackComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation

class BossAttackComponent: BaseComponent {
    var attachedSubComponent = [BossAttackSubComponent]()
    var currentAttackingComponent: BossAttackSubComponent?
    var coolDown = 0.0
    private var cachedSpriteComponent: SpriteComponent?
    private var cachedMoveComponent: MoveComponent?
    override init() {
        super.init()
        attachedSubComponent.append(BossBorderOfWaveAndParticle(attachedAttackComponent: self))
        attachedSubComponent.append(BossAttackLaser(attachedAttackComponent: self))
        attachedSubComponent.append(BossAttackRingOfBullets(attachedAttackComponent: self))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getSpriteComponent() -> SpriteComponent? {
        if cachedSpriteComponent == nil {
            cachedSpriteComponent = entity?.component(ofType: SpriteComponent.self)
        }
        return cachedSpriteComponent
    }

    func getMovementComponent() -> MoveComponent? {
        if cachedMoveComponent == nil {
            cachedMoveComponent = entity?.component(conformingTo: MoveComponent.self)
        }
        return cachedMoveComponent
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
