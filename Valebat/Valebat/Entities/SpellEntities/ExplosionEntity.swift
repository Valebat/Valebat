//
//  ExplosionEntity.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/4/21.
//

import GameplayKit

class ExplosionEntity: BaseEntity {

    init(position: CGPoint, scale: Int) {
        super.init()
        let spriteTextures = TextureUtilities.generateTextures(assetName: "explosion")
        let spriteTexture = spriteTextures[0]
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
            .applying(CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale)))
        addComponent(SpriteComponent(animatedTextures: spriteTextures, size: spriteSize, position: position, runForever: false))
        addComponent(PhysicsComponent(physicsBody: SKPhysicsBody(texture: spriteTexture, size: spriteSize), collisionType: .playerAttack))
        let damage = PlayerModifierUtil.playerDamageMultiplier * TestConstants.damageValue // Some constant
        addComponent(InstantDamageComponent(damage: damage, type: .pure))
        addComponent(AutoDestructComponent(timer: Double(spriteTextures.count) * 0.1))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func getSpriteFolder(for spell: Spell) -> String {
        if let singleElementSpell = spell as? SingleElementSpell {
            let elementType = singleElementSpell.damageType
            switch elementType {
            case .water:
                return "WB00"
            case .earth:
                return "EB00"
            case .fire:
                return  "FB00"
            default:
                return "GB00"
            }
        } else {
            switch spell.self {
            case is SteamSpell:
                return "SB00"
            case is MagmaSpell:
                return "AB00"
            case is MudSpell:
                return "MB00"
            default:
                return "GB00"
            }
        }
    }

    static func getAnimatedSpell(for spell: Spell) -> [SKTexture] {
        return TextureUtilities.generateTextures(assetName: getSpriteFolder(for: spell))
    }

}
