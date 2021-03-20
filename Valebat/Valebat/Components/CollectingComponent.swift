//
//  CollectingComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

class CollectingComponent: GKComponent, PlayerComponent, ContactBeginNotifiable {
    var player: Player?

    func contactDidBegin(with entity: GKEntity) {
        if let collectible = entity as? CollectibleEntity,
           let player = self.player {
            collectible.onCollect(player: player)
            EntityManager.getInstance().remove(collectible)
        }
    }
}
