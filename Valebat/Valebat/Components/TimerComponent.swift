//
//  AdvanceLevelComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class TimerComponent: GKComponent {
    var clock: Double
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

        if clock <= 0 {
            parent.addComponent(spawnedComponent)
            parent.removeComponent(ofType: TimerComponent.self)
            if self.replacementSpriteComponent != nil {
                parent.removeComponent(ofType: SpriteComponent.self)
                parent.addComponent(replacementSpriteComponent!)
            }
            EntityManager.getInstance().remove(parent)
            EntityManager.getInstance().add(parent)
        }
    }
}
