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

    func playerJoystickMoved(velocity: CGPoint, angular: CGFloat) {
        guard let playerMoveComp = player?.component(ofType: PlayerMoveComponent.self) else {
            return
        }

        playerMoveComp.movePlayer(velocity: velocity * HUDConstants.joystickVelocityMultiplier,
                                  angular: angular)
    }

    private func mapBasicType(elementQueue: [BasicType]) -> [Element] {
        let playerStats = PlayerStatsManager.getInstance()
        return elementQueue.compactMap({ playerStats.elements[$0] ?? nil })
    }
}
