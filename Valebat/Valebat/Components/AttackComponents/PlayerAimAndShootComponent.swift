//
//  PlayerAimAndShootComponent.swift
//  Valebat
//
//  Created by Zhang Yifan on 1/5/21.
//

import GameplayKit
import CoreGraphics

class PlayerAimAndShootComponent: BaseComponent, PlayerComponent {

    var player: PlayerEntity?

    let movementToIndicator: [String: AimIndicatorComponent.Type] =
        ["straight_line": AimIndicatorComponent.self, "projectile": LobIndicatorComponent.self]

    override func update(deltaTime seconds: TimeInterval) {
        guard let userInput = player?.userInputInfo else {
            return
        }
        if userInput.spellJoystickMoved {
            spellJoystickMoved(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
        }
        if userInput.spellJoystickEnd {
            spellJoystickEnded(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            userInput.spellJoystickEnd = false
        }
    }

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
            try player?.entityManager?.shootSpell(from: playerPos, with: direction, using: elementQueue)
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
            guard let spellManager = player?.entityManager?.currentSession?.spellManager else {
                return
            }
            let currentSpell = try spellManager.combine(elements: elementQueue)
            let indicatorType = movementToIndicator[currentSpell.movement.identifier]
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

    private func mapBasicType(elementQueue: [BasicType]) -> [Element] {
        guard let playerStats = player?.entityManager?.currentSession?.playerStats else {
            return []
        }
        return elementQueue.compactMap({ playerStats.getElement(type: $0) })
    }

}
