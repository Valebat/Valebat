//
//  BossBorderOfWaveAndParticle.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class BossBorderOfWaveAndParticle: BossAttackSubComponent {

    func deathCleanUp() {
        return
    }
    static let conversion = CGFloat(Double.pi / 180.0)
    let duration: CGFloat = 10
    var timer: TimeInterval = 0.0
    let angularVelocity: CGFloat = 42.3 * BossBorderOfWaveAndParticle.conversion
    var currentShot = 0
    let bulletCoolDown: CGFloat = 0.06
    let linesOfBullets = 3
    let bulletDamage = 3.0
    var currentType = BasicType.pure
    init(attachedAttackComponent: BossAttackComponent) {
        self.attachedAttackComponent = attachedAttackComponent
    }
    func update(deltaTime: TimeInterval) {
        timer += deltaTime
        if !isCurrentlyCasting {
            return
        }
        if CGFloat(timer) > duration {
            isCurrentlyCasting = false
        } else {
            if bulletCoolDown * CGFloat(currentShot) < CGFloat(timer) {
                let angle = CGFloat(Double.pi) * sin(angularVelocity * CGFloat(timer))
                shootBullets(angle: angle)
                currentShot += 1
            }
        }
    }

    var isCurrentlyCasting: Bool = false

    func triggerAttack() {
        if !isCurrentlyCasting {
            isCurrentlyCasting = true
            timer = 0.0
            currentShot = 0
            currentType = BasicType.getRandomType()
        }
    }

    var attachedAttackComponent: BossAttackComponent?

    var coolDown: TimeInterval = 14

    func shootBullets(angle: CGFloat) {
        guard let position = attachedAttackComponent?.getSpriteComponent()?.node.position else {
           return
        }
        for index in 0 ..< linesOfBullets {
            let currentAngle = angle + CGFloat(Double.pi) * 2 * CGFloat(index) / CGFloat(linesOfBullets)
            let launchVelocity = CGVector(angle: currentAngle) * 4.5
            let fireBall = StarProjectile(velocity: launchVelocity, position: position, damageType: currentType, damageValue: CGFloat(bulletDamage))
            attachedAttackComponent?.baseEntity?.entityManager?.add(fireBall)
        }
    }

}
