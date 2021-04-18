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
    let totalFireBall = 30
    let fireBallDamage = 5
    var currentFireBall = 0
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
        currentFireBall = 0
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
        if currentTimer > Double(currentFireBall) * totalCastTime / Double(totalFireBall) {
            let offsetAngle = spread / CGFloat(totalFireBall) * CGFloat(currentFireBall) - spread / 2
            launchFireBall(angle: startAngle + offsetAngle, type: currentType)
            currentFireBall += 1
        }
        if currentFireBall == totalFireBall {
            isCurrentlyCasting = false
        }
    }

    func launchFireBall(angle: CGFloat, type: BasicType) {
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
