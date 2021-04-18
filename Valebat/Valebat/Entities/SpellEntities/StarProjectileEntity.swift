//
//  StarProjectiles.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation
import GameplayKit

class StarProjectileEntity: BaseProjectileEntity {

    init(velocity: CGVector, position: CGPoint, damageType: BasicType, damageValue: CGFloat) {
        let spriteTexture = CustomTexture.initialise(imageNamed: StarProjectileEntity.getImage(type: damageType))
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize * 0.5,
                                height: ViewConstants.gridSize * 0.5 / widthHeightRatio)
        super.init(texture: spriteTexture, size: spriteSize, physicsType: .enemyAttack,
                   position: position, velocity: velocity)
        addComponent(InstantDamageComponent(damage: damageValue, type: damageType))
        let effectParams: [Any] = [TextureUtilities.generateTextures(assetName: "explosion"), 0.05]
        addComponent(SpellExplodeOnHitComponent(effectParams: effectParams))
    }

    static func getImage(type: BasicType) -> String {
        switch type {
        case .water:
            return "bluestar"
        case .earth:
            return "greenstar"
        case .fire:
            return  "redstar"
        default:
            return "purestar"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
