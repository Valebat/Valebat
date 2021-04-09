//
//  EntityManager+UserInputDelegate.swift
//  Valebat
//
//  Created by Zhang Yifan on 18/3/21.
//

import CoreGraphics
import GameplayKit

extension EntityManager: UserInputDelegate {
    func spellJoystickEnded(angular: CGFloat, elementQueue: [BasicType]?) {
        guard let aimIndicatorComp = player?.component(ofType: AimIndicatorComponent.self) else {
            return
        }
        aimIndicatorComp.onJoystickEnded()

        guard let playerPos = player?.component(ofType: SpriteComponent.self)?.node.position else {
            return
        }

        let direction = CGVector(dx: -sin(angular), dy: cos(angular))
        let elementTypeQueue = elementQueue ?? []
        let elementQueue = mapBasicType(elementQueue: elementTypeQueue)
        do {
            try shootSpell(from: playerPos, with: direction, using: elementQueue)
        } catch SpellErrors.invalidLevelError {
            print("Wrong level was given")
        } catch SpellErrors.wrongBasicTypeError {
            print("Wrong element type was given")
        } catch {
            print("Unexpected error")
        }
    }

    func spellJoystickMoved(angular: CGFloat) {
        guard let aimIndicatorComp = player?.component(ofType: AimIndicatorComponent.self) else {
            return
        }

        aimIndicatorComp.onJoystickMoved(angle: angular,
                                         playerAngle: player?.component(ofType: SpriteComponent.self)?.node.zRotation)
    }

    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat) {
        guard let playerMoveComp = player?.component(ofType: PlayerMoveComponent.self) else {
            return
        }

        playerMoveComp.movePlayer(velocity: velocity * HUDConstants.joystickVelocityMultiplier,
                                  angular: angular)
    }

    func restartClicked() {
        self.restart()
    }

    private func mapBasicType(elementQueue: [BasicType]) -> [Element] {
        let playerStats = currentSession.playerStats
        return elementQueue.compactMap({ playerStats.elements[$0] ?? nil })
    }
}
