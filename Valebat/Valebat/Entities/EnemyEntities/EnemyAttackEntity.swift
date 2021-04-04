//
//  EnemyAttackEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 28/3/21.
//

import GameplayKit

class EnemyAttackEntity: GKEntity {

    init(velocity: CGVector, position: CGPoint, damageType: BasicType, damageValue: CGFloat) {
        super.init()

        let spriteTexture = SKTexture(imageNamed: "GB001")
        let widthHeightRatio = spriteTexture.size().width / spriteTexture.size().height
        let spriteSize = CGSize(width: ViewConstants.gridSize,
                                height: ViewConstants.gridSize / widthHeightRatio)
        let spriteComponent = SpriteComponent(texture: spriteTexture,
                                              size: spriteSize,
                                              position: position, zPosition: 3, isStatic: false)
        addComponent(spriteComponent)
        addComponent(RegularMovementComponent(spellNode: spriteComponent.node, velocity: velocity, initialPosition: position))
        let spellPhysicsBody = SKPhysicsBody(texture: spriteTexture, size: spriteSize)
        addComponent(PhysicsComponent(physicsBody: spellPhysicsBody, collisionType: .enemyAttack))

        addComponent(InstantDamageComponent(damage: damageValue, type: damageType))
        addComponent(SpellHitComponent(animatedTextures: buildEndAnimation(), timePerFrame: 0.05, effectParams: []))
    }

    func buildEndAnimation() -> [SKTexture] {
        let spellAnimatedAtlas = SKTextureAtlas(named: "explosion")
        var animatedFrames: [SKTexture] = []
        let numImages = spellAnimatedAtlas.textureNames.count
        for index in 1...(numImages - 1) {
            let spellTextureName = "explosion" + String(index)
            animatedFrames.append(spellAnimatedAtlas.textureNamed(spellTextureName))
        }
        return animatedFrames
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
