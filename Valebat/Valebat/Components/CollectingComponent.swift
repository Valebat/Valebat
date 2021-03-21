//
//  CollectingComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

class CollectingComponent: GKComponent, PlayerComponent, ContactBeginObserver {
    var player: PlayerEntity?

    func contactDidBegin(with entity: GKEntity) {
        if let collectible = entity as? CollectibleEntity,
           let player = self.player {
            collectible.onCollect(player: player)
            EntityManager.getInstance().remove(collectible)
        }
    }

    override func didAddToEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactBeginObservers[ObjectIdentifier(self)] = self
    }
    override func willRemoveFromEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactBeginObservers.removeValue(forKey: ObjectIdentifier(self))
    }
}
