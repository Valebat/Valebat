//
//  ClientPlayerAimAndShootComponent.swift
//  Valebat
//
//  Created by Zhang Yifan on 1/5/21.
//

import GameplayKit

class ClientPlayerAimAndShootComponent: PlayerAimAndShootComponent {
    var spellShoot: Bool = false

    override func update(deltaTime seconds: TimeInterval) {
        guard let userInput = player?.userInputInfo else {
            return
        }
        if userInput.spellJoystickMoved {
            spellJoystickMoved(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            spellShoot = false
        }
        if userInput.spellJoystickEnd && !(spellShoot) {
            spellJoystickEnded(angular: userInput.spellJoystickAngular,
                               elementQueue: userInput.elementQueueArray,
                               player: player)
            userInput.spellJoystickEnd = false
            spellShoot = true
        }
    }
}
