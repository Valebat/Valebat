//
//  BossEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BossEntity: EnemyEntity, BaseMapEntity {
    init() {
        let position: CGPoint = CGPoint(x: ViewConstants.sceneWidth * ViewConstants.bossSpawnOffset,
                                        y: ViewConstants.sceneHeight * ViewConstants.bossSpawnOffset)
        let startingHP: CGFloat = 200
        let image = "boss"

        super.init(position: position, image: image, startingHP: startingHP)
        setUpDamageTaker()
        setUpHealth(startingHP: startingHP)
        setUpMovement(initialPosition: position)
        setUpAttack()
        setUpStateMachine()
        setUpSpriteAndPhysics(imageName: image, position: position)
        setUpDeath()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setUpSpriteAndPhysics(imageName: String, position: CGPoint) {
        let texture = SKTexture(imageNamed: "boss")
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize * 3
        let size = CGSize(width: length, height: length)
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position, isStatic: false)
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        addComponent(spriteComponent)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .enemy))
        addComponent(HealthBarComponent(barWidth: texture.size().width, barOffset: texture.size().height / 2))
    }
}
