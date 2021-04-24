//
//  ObjectiveDetectionComponent.swift
//  Valebat
//
//  Created by Jing Lin Shi on 31/3/21.
//

import GameplayKit

class ObjectiveDetectionComponent: BaseComponent {
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

    func open() {
        guard let entityManager = baseEntity?.entityManager else {
            return
        }
        parent.removeComponent(ofType: Self.self)
        parent.addComponent(spawnedComponent)
        if self.replacementSpriteComponent != nil {
            entityManager.replaceSprite(parent, component: self.replacementSpriteComponent!)
        }
    }
}
