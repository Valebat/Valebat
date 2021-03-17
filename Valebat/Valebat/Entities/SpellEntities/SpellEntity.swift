//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 16/3/21.
//

import GameplayKit

class SpellEntity: GKEntity {

    init(entityManager: EntityManager, velocity: CGVector, spell: Spell) {
        super.init()
        let spriteComponent = buildSpell()
        addComponent(spriteComponent)
        addComponent(SpellCastComponent(spellNode: spriteComponent.node, velocity: velocity,
                                        entityManager: entityManager))
        let element = spell.element
        if element.type.isSingle {
            addComponent(InstantDamageComponent(damage: CGFloat(element.level),
                                                type: element.type.associatedDamageType ?? .pure))
        } else {
            addComponent(InstantDamageComponent(water: spell.damageTypes.contains(.water) ? CGFloat(element.level) : 0.0,
                                                earth: spell.damageTypes.contains(.earth) ? CGFloat(element.level) : 0.0,
                                                fire: spell.damageTypes.contains(.fire) ? CGFloat(element.level) : 0.0,
                                                pure: spell.damageTypes.contains(.pure) ? CGFloat(element.level) : 0.0))
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildSpell() -> SpriteComponent {
        let spellAnimatedAtlas = SKTextureAtlas(named: "FB00")
        var animatedFrames: [SKTexture] = []

        let numImages = spellAnimatedAtlas.textureNames.count
        for index in 1...numImages {
            let spellTextureName = "FB00\(index)"
            animatedFrames.append(spellAnimatedAtlas.textureNamed(spellTextureName))
        }
        let firstFrame = animatedFrames[0]
        let spellSize = CGSize(width: firstFrame.size().width, height: firstFrame.size().height)
        let spellComponent = SpriteComponent(entity: self, texture: firstFrame, size: spellSize)
        return spellComponent
    }

}

extension ContactAllNotifiable {
    func contactDidEnd(with entity: GKEntity) {

    }
}
