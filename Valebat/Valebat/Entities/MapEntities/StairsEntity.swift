//
//  StairsEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 30/3/21.
//

import GameplayKit

class StairsEntity: BaseInteractableEntity, BaseMapObjectEntity, ObjectiveObserver {

    let objectType: MapObjectEnum = .stairs
    let pos: CGPoint
    let size: CGSize

    init(size: CGSize, timer: Double, position: CGPoint) {
        pos = position
        self.size = size
        let texture = SKTexture(imageNamed: "stairs_closed")
        super.init(texture: texture, size: size, physicsType: nil, position: position)
        let postObjectiveSprite = SpriteComponent(texture: SKTexture(imageNamed: "stairs_open"),
                                                  size: size, position: position)
        let objectiveDetectionComponent = ObjectiveDetectionComponent(component: AdvanceLevelComponent(at: position),
                                                                      parent: self,
                                                                      sprite: postObjectiveSprite)
        addComponent(objectiveDetectionComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func objectiveUpdate() {
        let objectiveDetectionComponent = self.component(ofType: ObjectiveDetectionComponent.self)
        objectiveDetectionComponent?.open()
    }

    func reset() {
        self.removeComponent(ofType: ObjectiveDetectionComponent.self)
        self.removeComponent(ofType: SpriteComponent.self)
        self.removeComponent(ofType: AdvanceLevelComponent.self)
        let texture = SKTexture(imageNamed: "stairs_closed")
        addComponent(SpriteComponent(texture: texture, size: size, position: self.pos))
        let objectiveDetectionComponent = ObjectiveDetectionComponent(component: AdvanceLevelComponent(at: self.pos),
                                                                      parent: self, sprite: self.component(ofType: SpriteComponent.self) ??
                                                                        SpriteComponent(texture: SKTexture(imageNamed: "stairs_open"),
                                                                                        size: self.size, position: self.pos))
        addComponent(objectiveDetectionComponent)
    }
}
