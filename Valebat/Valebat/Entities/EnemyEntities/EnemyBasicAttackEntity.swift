//
//  EnemyAttackEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyBasicAttackEntity: BaseProjectileEntity {

    init(velocity: CGVector, position: CGPoint, damageType: BasicType, damageValue: CGFloat) {

        let spriteTextures = TextureUtilities
            .generateTextures(assetName: EnemyBasicAttackEntity.getImage(type: damageType))
        let widthHeightRatio = spriteTextures[0].size().width / spriteTextures[0].size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        super.init(textures: spriteTextures, size: spriteSize, physicsTexture: spriteTextures[0],
                   physicsType: .enemyAttack,
                   position: position, velocity: velocity)
        addComponent(InstantDamageComponent(damage: damageValue, type: damageType))
        let effectParams: [Any] = [TextureUtilities.generateTextures(assetName: "explosion"), 0.05]
        addComponent(SpellExplodeOnHitComponent(effectParams: effectParams))
    }

    static func getImage(type: BasicType) -> String {
        switch type {
        case .water:
            return "WB00"
        case .earth:
            return "EB00"
        case .fire:
            return  "FB00"
        default:
            return "GB00"
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
