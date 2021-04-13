//
//  BossAttackLaser.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit
class BossAttackLaser: BossAttackSubComponent {
    weak var attachedAttackComponent: BossAttackComponent?
    let damage: CGFloat = 15.0
    let timeToPrepare: TimeInterval = 1.0
    var currentAngle: CGFloat = 0.0
    let laserTimer = 4.0
    let laserRotationSpeed = 25.0 * CGFloat(Double.pi) / 180.0
    var activated = false
    var laserEntity: LaserSpell?
    var currentTimer: TimeInterval = 0.0
    var coolDown: TimeInterval = 6.0
    init(attachedAttackComponent: BossAttackComponent) {
        self.attachedAttackComponent = attachedAttackComponent
    }

    func update(deltaTime: TimeInterval) {
        currentTimer += deltaTime
        if !isCurrentlyCasting {
            return
        }
        var ratio = CGFloat(currentTimer / timeToPrepare)
        ratio = ratio > 1 ? 1 : ratio
        laserEntity?.reposition(origin: getPosition(), currentSizeRatio: ratio, currentAngle: currentAngle)
        if currentTimer < timeToPrepare {
            laserEntity?.resize(widthRatio: ratio, lengthRatio: ratio)
            laserEntity?.changeOpacity(opacity: ratio)
        } else if currentTimer > laserTimer {
            finishLaser()
        } else {
            if !activated {
                laserEntity?.component(ofType: DPSDamageComponent.self)?.damageValues[.pure] = damage
                activated = true
            }
            let angle = getAngle() ?? 0
            let offset = (angle - currentAngle + 2 * CGFloat(Double.pi)).truncatingRemainder(dividingBy: 2 * CGFloat(Double.pi))
            if offset > CGFloat(Double.pi) {
                currentAngle -= CGFloat(deltaTime) * laserRotationSpeed
            } else {
                currentAngle += CGFloat(deltaTime)  * laserRotationSpeed
            }
            laserEntity?.rotate(angle: currentAngle)
        }
    }

    func getAngle() -> CGFloat? {
        guard let currentPosition = attachedAttackComponent?.getMovementComponent()?.currentPosition,
              let playerPosition = attachedAttackComponent?.baseEntity?.entityManager?.lastKnownPlayerPosition else {
            return nil
        }
        return (playerPosition - currentPosition).calculateAngle()
    }

    func getPosition() -> CGPoint {
        return attachedAttackComponent?.getMovementComponent()?.currentPosition ?? CGPoint(x: 0, y: 0)
    }
    func finishLaser() {
        attachedAttackComponent?.baseEntity?.entityManager?.remove(laserEntity!)
        isCurrentlyCasting = false
    }
    var isCurrentlyCasting: Bool = false

    func triggerAttack() {
        if isCurrentlyCasting {
            return
        }
        currentAngle = getAngle() ?? 0.0
        currentTimer = 0.0
        activated = false
        isCurrentlyCasting = true
        laserEntity = LaserSpell()
        laserEntity?.resize(widthRatio: 0.01, lengthRatio: 0.01)
        attachedAttackComponent?.baseEntity?.entityManager?.add(laserEntity!)
        laserEntity?.reposition(origin: getPosition(), currentSizeRatio: 0.01, currentAngle: currentAngle)
        laserEntity?.changeOpacity(opacity: 0.0)
        laserEntity?.rotate(angle: currentAngle)

    }
}
