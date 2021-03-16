//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 16/3/21.
//

import GameplayKit

class SpellEntity: GKEntity {

    init(entityManager: EntityManager) {
        super.init()
        addComponent(buildSpell())
        addComponent(MoveComponent(maxSpeed: 150, maxAcceleration: 5, radius: 10,
                                   entityManager: entityManager))

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
