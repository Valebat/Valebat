//
//  BossAttackRingOfFire.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class BossAttackRingOfBullets: BossAttackSubComponent {

    func deathCleanUp() {
        return
    }

    weak var attachedAttackComponent: BossAttackComponent?
    let totalCastTime = 1.0
    var coolDown: TimeInterval = 2.5
    let totalBulletCount = 30
    let fireBallDamage = 5
    var currentBulletCount = 0
    var currentTimer: TimeInterval = 0.0
    let spread: CGFloat = 85.0 * CGFloat(Double.pi) / 180.0
    var startAngle: CGFloat = 0.0
    var currentType = BasicType.pure

    init(attachedAttackComponent: BossAttackComponent) {
        self.attachedAttackComponent = attachedAttackComponent
    }

    func triggerAttack() {
        if isCurrentlyCasting {
            return
        }
        guard let playerPosition = attachedAttackComponent?.baseEntity?.entityManager?.lastKnownPlayerPosition,
              let currentPosition = attachedAttackComponent?.getCurrentPosition() else {
            return
        }
        isCurrentlyCasting = true
        currentBulletCount = 0
        currentTimer = 0
        currentType = BasicType.getRandomType()
        startAngle = (playerPosition - currentPosition).calculateAngle()
    }

    var isCurrentlyCasting: Bool = false

    func update(deltaTime: TimeInterval) {
        if !isCurrentlyCasting {
            return
        }
        currentTimer += deltaTime
        if currentTimer > Double(currentBulletCount) * totalCastTime / Double(totalBulletCount) {
            let offsetAngle = spread / CGFloat(totalBulletCount) * CGFloat(currentBulletCount) - spread / 2
            launchBullet(angle: startAngle + offsetAngle, type: currentType)
            currentBulletCount += 1
        }
        if currentBulletCount == totalBulletCount {
            isCurrentlyCasting = false
        }
    }

    func launchBullet(angle: CGFloat, type: BasicType) {
        guard let entityManager = attachedAttackComponent?.baseEntity?.entityManager,
              let position = attachedAttackComponent?.getCurrentPosition() else {
            return
        }
        let launchVelocity = CGVector(angle: angle) * 4.0
        let fireBall: EnemyBasicAttackEntity = EnemyBasicAttackEntity(velocity: launchVelocity,
                                                                      position: position,
                                                                      damageType: type,
                                                                      damageValue: CGFloat(fireBallDamage))
        entityManager.add(fireBall)
    }
}
