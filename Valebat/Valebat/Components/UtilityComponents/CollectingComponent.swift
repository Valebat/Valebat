//
//  CollectingComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

class CollectingComponent: BaseComponent, PlayerComponent, ContactObserver {
    var player: PlayerEntity?

    func contact(with entity: BaseEntity, seconds: TimeInterval) {
        if let collectible = entity as? CollectibleEntity,
           let player = self.player {
            collectible.onCollect(player: player)
            baseEntity?.entityManager?.remove(entity)
        }
    }

    override func didAddToEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactObservers[ObjectIdentifier(self)] = self
    }
    override func willRemoveFromEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactObservers.removeValue(forKey: ObjectIdentifier(self))
    }
}
