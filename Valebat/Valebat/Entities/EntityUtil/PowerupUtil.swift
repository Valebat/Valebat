//
//  PowerupUtil.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

class PowerupUtil {
    
    static func collectedPowerup(_ powerup: PowerupEnum, player: PlayerEntity) {
        switch powerup {
        case .heal:
            player.component(ofType: HealthComponent.self)?.healDamage(5.0)
        case .damage:
            PlayerModifierUtil.playerDamageMultiplier *= 1.2
        case .speed:
            PlayerModifierUtil.playerSpeedMultiplier *= 1.2
        }
    }

    static func resetPowerups() {
        PlayerModifierUtil.playerDamageMultiplier = 1.0
        PlayerModifierUtil.playerSpeedMultiplier = 1.0
    }
}
