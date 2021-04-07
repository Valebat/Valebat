//
//  EnemyAttackEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyAttackEntity: BaseProjectileEntity {

    init(velocity: CGVector, position: CGPoint, damageType: BasicType, damageValue: CGFloat) {

        let spriteTexture = SKTexture(imageNamed: "GB001")
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        super.init(texture: spriteTexture, size: spriteSize, physicsType: .enemyAttack,
                   position: position, velocity: velocity)
        addComponent(InstantDamageComponent(damage: damageValue, type: damageType))
        addComponent(SpellHitComponent(animatedTextures:
                                        TextureUltilties.generateTextures(assetName: "explosion"),
                                       timePerFrame: 0.05, effectParams: []))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
