//
//  AdvanceLevelComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class TimerComponent: BaseComponent {
    var clock: Double
    var active: Bool = true
    let parent: GKEntity
    let spawnedComponent: AdvanceLevelComponent
    let replacementSpriteComponent: SpriteComponent?

    init(timer: Double, component: AdvanceLevelComponent, parent: GKEntity) {
        self.clock = timer
        self.parent = parent
        self.spawnedComponent = component
        self.replacementSpriteComponent = nil
        super.init()
    }

    init(timer: Double, component: AdvanceLevelComponent, parent: GKEntity, sprite: SpriteComponent) {
        self.clock = timer
        self.parent = parent
        self.spawnedComponent = component
        self.replacementSpriteComponent = sprite
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        clock -= seconds
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        if clock <= 0 && active {
            active = false
            entityManager.removeComponentOfEntity(parent, component: self)
            entityManager.addComponentToEntity(parent, component: spawnedComponent)
            if self.replacementSpriteComponent != nil {
                entityManager.replaceSprite(parent, component: self.replacementSpriteComponent!)
            }
        }
    }
}
