//
//  ExplosionEntity.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/4/21.
//

import GameplayKit

class ExplosionEntity: BaseInteractableEntity {

    init(position: CGPoint, scale: Int) {
        let spriteTextures = TextureUtilities.generateTextures(assetName: "explosion")
        let spriteTexture = spriteTextures[0]
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
            .applying(CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale)))
        super.init(textures: spriteTextures, size: spriteSize, physicsTexture: spriteTexture,
                   physicsType: .playerAttack, position: position)
        let damage = PlayerModifierUtil.playerDamageMultiplier * TestConstants.damageValue // Some constant
        addComponent(InstantDamageComponent(damage: damage, type: .pure))
        addComponent(AutoDestructComponent(timer: Double(spriteTextures.count) * 0.1))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
