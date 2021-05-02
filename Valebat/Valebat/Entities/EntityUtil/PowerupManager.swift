//
//  PowerupUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

import SpriteKit

class PowerupManager {
    let playerModifiers = PlayerModifiers()

    let maxPlayerDamageMultiplier: CGFloat = 2.0
    let maxPlayerSpeedMultiplier: CGFloat = 2.0

    func collectedPowerup(_ powerup: PowerupEnum, player: PlayerEntity) {
        switch powerup {
        case .heal:
            player.component(ofType: HealthComponent.self)?.healDamage(5.0)
        case .damage:
            self.playerModifiers.playerDamageMultiplier = min(self.playerModifiers.playerDamageMultiplier * 1.2,
                                                              maxPlayerDamageMultiplier)
        case .speed:
            self.playerModifiers.playerSpeedMultiplier = min(self.playerModifiers.playerSpeedMultiplier * 1.2,
                                                             maxPlayerSpeedMultiplier)
        }
    }

    func resetPowerups() {
        self.playerModifiers.playerDamageMultiplier = 1.0
        self.playerModifiers.playerSpeedMultiplier = 1.0
    }
}
