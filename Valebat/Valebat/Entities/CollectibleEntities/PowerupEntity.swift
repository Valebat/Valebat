//
//  PowerupEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

import GameplayKit

class PowerupEntity: BaseInteractableEntity, CollectibleEntity {
    var powerupType: PowerupEnum?

    func onCollect(player: PlayerEntity) {
        guard let type = powerupType else {
            return
        }
        entityManager?.currentSession?.objectiveManager.incrementPowerupCounter()
        PowerupUtil.collectedPowerup(type, player: player)
    }

    init(position: CGPoint) {

        powerupType = PowerupEnum(rawValue: Int(arc4random()) % Int(PowerupEnum.allCases.count))

        var texture = CustomTexture.initialise(imageNamed: "powerup_unknown")

        switch powerupType {
        case .heal:
            texture = CustomTexture.initialise(imageNamed: "powerup_heal")
        case .speed:
            texture = CustomTexture.initialise(imageNamed: "powerup_speed")
        case .damage:
            texture = CustomTexture.initialise(imageNamed: "powerup_attack")
        case .none:
            break
        }
        let size = CGSize(width: ViewConstants.gridSize, height: ViewConstants.gridSize)
        super.init(texture: texture, size: size, physicsType: .collectible, position: position)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
