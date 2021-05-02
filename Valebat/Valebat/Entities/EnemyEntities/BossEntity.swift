//
//  BossEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BossEntity: BaseInteractableEntity {
    var stateMachine: GKStateMachine?
    let attackRange: CGFloat = 500.0
    let moveSpeed: CGFloat = 100.0

    init() {
        let position: CGPoint = CGPoint(x: ViewConstants.sceneWidth * ViewConstants.bossSpawnOffset,
                                        y: ViewConstants.sceneHeight * ViewConstants.bossSpawnOffset)
        let startingHP: CGFloat = 500
        let image = "boss"
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize * 3
        let size = CGSize(width: length, height: length)
        let texture = CustomTexture.initialise(imageNamed: image)
        super.init(texture: texture, size: size, physicsType: .enemy, position: position, isStatic: false)
        addComponent(HealthComponent(health: startingHP))
        addComponent(HealthBarComponent(barWidth: texture.size().width, barOffset: texture.size().height / 2))
        addComponent(DamageTakerComponent.getDamageTaker(type: .pure))
        addComponent(EnemyMoveComponent(initialPosition: position))
        addComponent(EnemyDeathComponent(exp: 200))
        addComponent(BossAttackComponent())
        setUpStateMachine()
    }

    private func setUpStateMachine() {
        let moveState = BossMoveState(for: self, attackRange: attackRange, speed: moveSpeed)
        let attackState = BossAttackState(for: self, attackRange: attackRange)
        self.stateMachine = GKStateMachine(states: [moveState, attackState])
        self.stateMachine?.enter(BossMoveState.self)
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        self.stateMachine?.update(deltaTime: seconds)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
