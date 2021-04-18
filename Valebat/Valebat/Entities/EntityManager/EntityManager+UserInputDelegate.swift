//
//  EntityManager+UserInputDelegate.swift
//  Valebat
//
//  Created by Zhang Yifan on 18/3/21.
//

import CoreGraphics
import GameplayKit

extension EntityManager: UserInputDelegate {
    static let movementToIndicator: [String: AimIndicatorComponent.Type] =
        ["straight_line": AimIndicatorComponent.self, "projectile": LobIndicatorComponent.self]

    func spellJoystickEnded(angular: CGFloat, elementQueue: [BasicType]?, player: PlayerEntity?) {
        guard let aimIndicatorComp = player?.component(ofType: AimIndicatorComponent.self) else {
            return
        }
        let aiming = aimIndicatorComp.onJoystickEnded()

        guard let lobIndicatorComp = player?.component(ofType: LobIndicatorComponent.self) else {
            return
        }
        let lobbing = lobIndicatorComp.onJoystickEnded()

        if !lobbing && !aiming {
            return
        }

        guard let playerPos = player?.component(ofType: SpriteComponent.self)?.node.position else {
            return
        }

        let direction = CGVector(dx: -sin(angular), dy: cos(angular))
        let elementTypeQueue = elementQueue ?? []
        let elementQueue = mapBasicType(elementQueue: elementTypeQueue)
        do {
            try shootSpell(from: playerPos, with: direction, using: elementQueue)
        } catch SpellErrors.invalidLevelError {
            print("Wrong level was given.")
        } catch SpellErrors.wrongBasicTypeError {
            print("Wrong element type was given.")
        } catch {
            print("Unexpected error.")
        }
    }

    func spellJoystickMoved(angular: CGFloat, elementQueue: [BasicType]?, player: PlayerEntity?) {

        let elementTypeQueue = elementQueue ?? []
        let elementQueue = mapBasicType(elementQueue: elementTypeQueue)
        do {
            guard let currentSpell = try self.currentSession?.spellManager.combine(elements: elementQueue) else {
                return
            }
            let indicatorType = EntityManager.movementToIndicator[currentSpell.movement.identifier]
                ?? AimIndicatorComponent.self
            guard let indicatorComp = player?.component(ofType: indicatorType) else {
                return
            }
            guard let playerPos = player?.component(ofType: SpriteComponent.self)?.node.position else {
                return
            }
            indicatorComp.onJoystickMoved(shootAngle: angular,
                                          playerAngle: player?.component(ofType: SpriteComponent.self)?.node.zRotation,
                                          playerPosition: playerPos)
        } catch SpellErrors.invalidLevelError {
            print("Wrong level was given.")
        } catch SpellErrors.wrongBasicTypeError {
            print("Wrong element type was given.")
        } catch {
            print("Unexpected error.")
        }
    }

    func restartClicked() {
        self.restart()
    }

    private func mapBasicType(elementQueue: [BasicType]) -> [Element] {
        guard let playerStats = currentSession?.playerStats else {
            return []
        }
        return elementQueue.compactMap({ playerStats.getElement(type: $0) })
    }
}
