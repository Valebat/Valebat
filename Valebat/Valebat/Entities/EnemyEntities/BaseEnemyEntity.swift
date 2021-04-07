//
//  BaseEnemyEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BaseEnemyEntity: BaseEntity {
    var image: String

    init(position: CGPoint, image: String = "enemy", startingHP: CGFloat = 10) {
        self.image = image
        super.init()
        setUpDamageTaker()
        setUpHealth(startingHP: startingHP)
        setUpMovement(initialPosition: position)
        setUpAttack()
        setUpStateMachine()
        setUpSpriteAndPhysics(imageName: image, position: position)
        setUpDeath()
    }

    func setUpDamageTaker() {
        addComponent(DamageTakerComponent())
    }

    func setUpHealth(startingHP: CGFloat) {
        addComponent(HealthComponent(health: startingHP))
    }
    func setUpDeath() {
        addComponent(EnemyDeathComponent())
    }

    func setUpAttack() {
        addComponent(EnemyAttackComponent(attackCooldown: 3.0, damageType: .pure, damageValue: 2))
    }
    func setUpStateMachine() {
        addComponent(EnemyStateMachineComponent())
    }

    func setUpMovement(initialPosition: CGPoint) {
        addComponent(EnemyMoveComponent(chaseSpeed: 120, normalSpeed: 30, initialPosition: initialPosition))
    }

    func setUpSpriteAndPhysics(imageName: String, position: CGPoint) {
        let texture = SKTexture(imageNamed: image)
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize
        let size = CGSize(width: length, height: length)
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position, isStatic: false)
        let physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        addComponent(spriteComponent)
        addComponent(PhysicsComponent(physicsBody: physicsBody, collisionType: .enemy))
        addComponent(HealthBarComponent(barWidth: texture.size().width, barOffset: texture.size().height / 2))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
