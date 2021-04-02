//
//  PowerupEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 1/4/21.
//

import GameplayKit

class PowerupEntity: GKEntity, CollectibleEntity {
    var powerupType: PowerupEnum?

    func onCollect(player: PlayerEntity) {
        guard let type = powerupType else {
            return
        }
        PowerupUtil.collectedPowerup(type)
    }

    init(position: CGPoint) {
        super.init()

        powerupType = PowerupEnum(rawValue: Int(arc4random()) % Int(PowerupEnum.allCases.count))

        var texture = SKTexture(imageNamed: "powerup_unknown")

        switch powerupType {
        case .heal:
            texture = SKTexture(imageNamed: "powerup_heal")
        case .speed:
            texture = SKTexture(imageNamed: "powerup_speed")
        case .damage:
            texture = SKTexture(imageNamed: "powerup_attack")
        case .none:
            break
        }

        let size = CGSize(width: ViewConstants.gridSize, height: ViewConstants.gridSize)

        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        let physicsBody = SKPhysicsBody(texture: texture, size: size)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .collectible))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
