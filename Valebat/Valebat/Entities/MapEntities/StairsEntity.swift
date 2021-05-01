//
//  StairsEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 30/3/21.
//

import GameplayKit

class StairsEntity: BaseInteractableEntity, BaseMapObjectEntity, ObjectiveObserver, ResettableEntity {
    let objectType: MapObjectEnum = .stairs
    let position: CGPoint
    let size: CGSize
    let preObjectiveSprite: SpriteComponent
    let postObjectiveSprite: SpriteComponent

    init(size: CGSize, position: CGPoint) {
        self.position = position
        self.size = size
        let texture = CustomTexture.initialise(imageNamed: "stairs_closed")
        self.preObjectiveSprite = SpriteComponent(texture: CustomTexture.initialise(imageNamed: "stairs_closed"),
                                                  size: size, position: position)
        self.postObjectiveSprite = SpriteComponent(texture: CustomTexture.initialise(imageNamed: "stairs_open"),
                                                   size: size, position: position)
        super.init(texture: texture, size: size, physicsType: nil, position: position)
        let advanceLevelComponent = AdvanceLevelComponent(at: position,
                                                          sprite: self.postObjectiveSprite)
        addComponent(advanceLevelComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func objectiveUpdate() {
        let advanceLevelComponent = self.component(ofType: AdvanceLevelComponent.self)
        advanceLevelComponent?.open()
    }

    func reset() {
        self.removeComponent(ofType: AdvanceLevelComponent.self)

        entityManager?.replaceSprite(self, component: preObjectiveSprite)

        let advanceLevelComponent = AdvanceLevelComponent(at: position,
                                                          sprite: self.postObjectiveSprite)
        addComponent(advanceLevelComponent)
    }
}
