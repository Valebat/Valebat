//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 16/3/21.
//

import GameplayKit

class PlayerSpellEntity: BaseProjectileEntity {

    init(velocity: CGVector, spell: Spell, position: CGPoint) {

        let spriteTextures = PlayerSpellEntity.getAnimatedSpell(for: spell)
        let spriteTexture = spriteTextures[0]
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        super.init(textures: spriteTextures, size: spriteSize, physicsTexture: spriteTexture, physicsType: .playerAttack, position: position, velocity: velocity)

        let damage = CGFloat(spell.level) * PlayerModifierUtil.playerDamageMultiplier
            * TestConstants.damageValue // Some constant
        if let basicSpell = spell as? SingleElementSpell {
            addComponent(InstantDamageComponent(damage: damage,
                                                type: basicSpell.damageType))
        } else if let compositeSpell = spell as? CompositeSpell {
            addComponent(InstantDamageComponent(water: compositeSpell.damageTypes.contains(.water) ? damage : 0.0,
                                                earth: compositeSpell.damageTypes.contains(.earth) ? damage : 0.0,
                                                fire: compositeSpell.damageTypes.contains(.fire) ? damage : 0.0,
                                                pure: compositeSpell.damageTypes.contains(.pure) ? damage : 0.0))
        }

        for (effect, effectParams) in zip(spell.effects, spell.effectParams) {
            addComponent(effect.init(animatedTextures: PlayerSpellEntity.buildEndAnimation(for: spell),
                                     timePerFrame: 0.05, effectParams: effectParams))
        }

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

    static func buildEndAnimation(for spell: Spell) -> [SKTexture] {
        return TextureUltilties.generateTextures(assetName: "explosion") // getSpriteFolder(for: spell) +
    }

    static func getAnimatedSpell(for spell: Spell) -> [SKTexture] {
        return TextureUltilties.generateTextures(assetName: getSpriteFolder(for: spell))
    }

}