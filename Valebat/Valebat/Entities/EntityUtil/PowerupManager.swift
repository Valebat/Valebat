//
//  PowerupUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

class PowerupManager {
    let playerModifiers = PlayerModifiers()

    func collectedPowerup(_ powerup: PowerupEnum, player: PlayerEntity) {
        switch powerup {
        case .heal:
            player.component(ofType: HealthComponent.self)?.healDamage(5.0)
        case .damage:
            self.playerModifiers.playerDamageMultiplier *= 1.2
        case .speed:
            self.playerModifiers.playerSpeedMultiplier *= 1.2
        }
    }

    func resetPowerups() {
        self.playerModifiers.playerDamageMultiplier = 1.0
        self.playerModifiers.playerSpeedMultiplier = 1.0
    }
}
