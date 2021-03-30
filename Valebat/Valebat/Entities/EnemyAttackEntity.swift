//
//  EnemyAttackEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import Foundation
import GameplayKit
class EnemyAttackEntity: GKEntity {

    init(velocity: CGVector, position: CGPoint, damageType: DamageType, damageValue: CGFloat) {
        super.init()

        let spriteTexture = SKTexture(imageNamed: "GB001")
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        let spriteComponent = SpriteComponent(texture: spriteTexture, size: spriteSize, position: position, zPosition: 3)
        addComponent(spriteComponent)
        addComponent(SpellCastComponent(spellNode: spriteComponent.node, velocity: velocity))
        let spellPhysicsBody = SKPhysicsBody(texture: spriteTexture, size: spriteSize)
        addComponent(PhysicsComponent(physicsBody: spellPhysicsBody, collisionType: .enemyAttack))

        addComponent(InstantDamageComponent(damage: damageValue, type: damageType))

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
