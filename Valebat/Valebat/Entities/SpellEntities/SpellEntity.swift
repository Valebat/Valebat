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

        let spriteTexture = buildSpellTexture()
        let spriteSize = spriteTexture.size()
        let spriteComponent = SpriteComponent(entity: self, texture: spriteTexture, size: spriteSize)
        addComponent(spriteComponent)

        addComponent(SpellCastComponent(spellNode: spriteComponent.node, velocity: velocity))

        let spellPhysicsBody = SKPhysicsBody(texture: spriteTexture, size: spriteSize)
        addComponent(PhysicsComponent(physicsBody: spellPhysicsBody, collisionType: .playerAttack))

        let element = spell.element
        let damage = CGFloat(element.level) * 5 // Some constant
        if element.type.isSingle {
            addComponent(InstantDamageComponent(damage: damage,
                                                type: element.type.associatedDamageType ?? .pure))
        } else {
            addComponent(InstantDamageComponent(water: spell.damageTypes.contains(.water) ? damage : 0.0,
                                                earth: spell.damageTypes.contains(.earth) ? damage : 0.0,
                                                fire: spell.damageTypes.contains(.fire) ? damage : 0.0,
                                                pure: spell.damageTypes.contains(.pure) ? damage : 0.0))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildSpellTexture() -> SKTexture {
        let spellAnimatedAtlas = SKTextureAtlas(named: "FB00")
        var animatedFrames: [SKTexture] = []

        let numImages = spellAnimatedAtlas.textureNames.count
        for index in 1...numImages {
            let spellTextureName = "FB00\(index)"
            animatedFrames.append(spellAnimatedAtlas.textureNamed(spellTextureName))
        }
        return animatedFrames[0]
    }

}
