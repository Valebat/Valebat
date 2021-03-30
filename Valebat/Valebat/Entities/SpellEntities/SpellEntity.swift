//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 16/3/21.
//

import GameplayKit

class SpellEntity: GKEntity {

    init(velocity: CGVector, spell: Spell) {
        super.init()

        let spriteTextures = buildSpellTexture(spell: spell)
        let spriteTexture = spriteTextures[0]
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        let spriteComponent = SpriteComponent(animatedTextures: spriteTextures, size: spriteSize)
        addComponent(spriteComponent)

        addComponent(SpellCastComponent(spellNode: spriteComponent.node, velocity: velocity))

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
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildSpellTexture(spell: Spell) -> [SKTexture] {
        let elementType = (spell as? SingleElementSpell)?.damageType
        var imgName = ""
        switch elementType {
        case .water:
            imgName = "WB00"
        case .earth:
            imgName = "EB00"
        case .fire:
            imgName = "FB00"
        default:
            imgName = "GB00"
        }

        let spellAnimatedAtlas = SKTextureAtlas(named: imgName)
        var animatedFrames: [SKTexture] = []

        let numImages = spellAnimatedAtlas.textureNames.count
        for index in 1...numImages {
            let spellTextureName = imgName + "\(index)"
            animatedFrames.append(spellAnimatedAtlas.textureNamed(spellTextureName))
        }
        return animatedFrames
    }

}
