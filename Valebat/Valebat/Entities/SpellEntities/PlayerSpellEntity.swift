//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 16/3/21.
//

import GameplayKit

class PlayerSpellEntity: BaseProjectileEntity {

    init(velocity: CGVector, spell: Spell, position: CGPoint, damageMultiplier: CGFloat = 1.0) {
        let spriteTextures = PlayerSpellEntity.getAnimatedSpell(for: spell)
        super.init(texture: spriteTextures[0],
                   size: PlayerSpellEntity.getSpriteSize(spriteTexture: spriteTextures[0]),
                   physicsType: .playerAttack, position: position, velocity: velocity,
                   movementType: spell.movement)
        let damage = CGFloat(spell.level) * damageMultiplier * DamageConstants.damageValue
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
            addComponent(effect.init(effectParams: effectParams))
        }
        self.component(conformingTo: SpellSpawnOnShootComponent.self)?.createEffect()
        self.component(ofType: SpriteComponent.self)?.animate(with: spriteTextures, runForever: true)
    }

    private static func getSpriteSize(spriteTexture: SKTexture) -> CGSize {
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        return spriteSize
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
                return "FB00"
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
