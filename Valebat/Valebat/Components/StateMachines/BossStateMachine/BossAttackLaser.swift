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
    var laserEntity: LaserSpellEntity?
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
        if currentTimer < timeToPrepare {
            laserEntity?.changeOpacity(opacity: ratio)
        } else if currentTimer > laserTimer {
            finishLaser()
        } else {
            if !activated {
                laserEntity?.component(ofType: DPSDamageComponent.self)?.damageValues[.pure] = damage
                activated = true
            }
            let offset = (getAngle() - currentAngle +
                            2 * CGFloat(Double.pi)).truncatingRemainder(dividingBy: 2 * CGFloat(Double.pi))
            if offset > CGFloat(Double.pi) {
                currentAngle -= CGFloat(deltaTime) * laserRotationSpeed
            } else {
                currentAngle += CGFloat(deltaTime)  * laserRotationSpeed
            }
        }
        laserEntity?.reposition(origin: getPosition(), currentSizeRatio: ratio, currentAngle: currentAngle)
    }

    func getAngle() -> CGFloat {
        guard let currentPosition = attachedAttackComponent?.getCurrentPosition(),
              let playerPosition = attachedAttackComponent?.baseEntity?.entityManager?.lastKnownPlayerPosition else {
            return 0.0
        }
        return (playerPosition - currentPosition).calculateAngle()
    }

    func getPosition() -> CGPoint {
        return attachedAttackComponent?.getCurrentPosition() ?? CGPoint(x: 0, y: 0)
    }
    
    func finishLaser() {
        isCurrentlyCasting = false
        guard let laser = laserEntity else {
            return
        }
        attachedAttackComponent?.baseEntity?.entityManager?.remove(laser)
        laserEntity = nil
    }
    
    var isCurrentlyCasting: Bool = false

    func triggerAttack() {
        if isCurrentlyCasting {
            return
        }
        currentTimer = 0.0
        activated = false
        isCurrentlyCasting = true
        let laser = LaserSpellEntity()
        laserEntity = laser
        attachedAttackComponent?.baseEntity?.entityManager?.add(laser)
        laserEntity?.reposition(origin: getPosition(), currentSizeRatio: 0.01, currentAngle: getAngle())
        laserEntity?.changeOpacity(opacity: 0.0)

    }
    
    func deathCleanUp() {
        if let entity = laserEntity {
            attachedAttackComponent?.baseEntity?.entityManager?.remove(entity)
        }
    }
}
