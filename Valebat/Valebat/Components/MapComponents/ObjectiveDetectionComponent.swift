//
//  ObjectiveDetectionComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class ObjectiveDetectionComponent: BaseComponent {
    var active: Bool = true
    let parent: BaseEntity
    let spawnedComponent: AdvanceLevelComponent
    let replacementSpriteComponent: SpriteComponent?

    init(component: AdvanceLevelComponent, parent: BaseEntity) {
        self.parent = parent
        self.spawnedComponent = component
        self.replacementSpriteComponent = nil
        super.init()
    }

    init(component: AdvanceLevelComponent, parent: BaseEntity, sprite: SpriteComponent) {
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
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        if entityManager.objectiveManager.isObjectiveCompleted() && active {
            active = false
            entityManager.removeComponentOfEntity(parent, component: self)
            entityManager.addComponentToEntity(parent, component: spawnedComponent)
            if self.replacementSpriteComponent != nil {
                entityManager.replaceSprite(parent, component: self.replacementSpriteComponent!)
            }
        }
    }
}
