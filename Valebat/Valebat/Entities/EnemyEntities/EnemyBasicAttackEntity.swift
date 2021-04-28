//
//  EnemyAttackEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyBasicAttackEntity: BaseProjectileEntity {

    init(velocity: CGVector, position: CGPoint, damageType: BasicType, damageValue: CGFloat) {
        let spriteTexture = Self.getSpriteTexture(damageType: damageType)
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        super.init(texture: spriteTexture, size: spriteSize, physicsType: .enemyAttack,
                   position: position, velocity: velocity)
        addComponent(InstantDamageComponent(damage: damageValue, type: damageType))
        let effectParams: [Any] = [TextureUtilities.generateTextures(assetName: "explosion"), 0.05]
        addComponent(SpellExplodeOnHitComponent(effectParams: effectParams))
        self.addAnimation(damageType: damageType)
    }

    class func getSpriteTexture(damageType: BasicType) -> SKTexture {
        let spriteTextures = TextureUtilities.generateTextures(assetName: Self.getImage(type: damageType))
        return spriteTextures[0]
    }

    func addAnimation(damageType: BasicType) {
        let spriteTextures = TextureUtilities.generateTextures(assetName: Self.getImage(type: damageType))
        self.component(ofType: SpriteComponent.self)?.animate(with: spriteTextures, runForever: true)
    }

    class func getImage(type: BasicType) -> String {
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
