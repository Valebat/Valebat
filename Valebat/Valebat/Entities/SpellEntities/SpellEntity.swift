//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 16/3/21.
//

import GameplayKit

class SpellEntity: GKEntity {

    init(velocity: CGVector, spell: Spell, position: CGPoint) {

        super.init()

        let spriteTextures = getAnimatedSpell(for: spell)
        let spriteTexture = spriteTextures[0]
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        let spriteComponent = SpriteComponent(animatedTextures: spriteTextures, size: spriteSize, position: position, isStatic: false)
        addComponent(spriteComponent)

        addComponent(RegularMovementComponent(spellNode: spriteComponent.node, velocity: velocity, initialPosition: position))

        let spellPhysicsBody = SKPhysicsBody(texture: spriteTexture, size: spriteSize)
        addComponent(PhysicsComponent(physicsBody: spellPhysicsBody, collisionType: .playerAttack))

        let damage = CGFloat(spell.level) * TestConstants.damageValue // Some constant
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
            addComponent(effect.init(animatedTextures: buildEndAnimation(for: spell),
                                     timePerFrame: 0.05, effectParams: effectParams))
        }

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getTexturesFromAtlas(atlasName: String) -> [SKTexture] {
        let atlas = SKTextureAtlas(named: atlasName)
        var animatedFrames: [SKTexture] = []
        let numImages = atlas.textureNames.count - 1
        for index in 1...numImages {
            let spellTextureName = atlasName + String(index)
            animatedFrames.append(atlas.textureNamed(spellTextureName))
        }
        return animatedFrames
    }

    func getSpriteFolder(for spell: Spell) -> String {
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

    func buildEndAnimation(for spell: Spell) -> [SKTexture] {
        return getTexturesFromAtlas(atlasName: "explosion") // getSpriteFolder(for: spell) +
    }

    func getAnimatedSpell(for spell: Spell) -> [SKTexture] {
        return getTexturesFromAtlas(atlasName: getSpriteFolder(for: spell))
    }

}
