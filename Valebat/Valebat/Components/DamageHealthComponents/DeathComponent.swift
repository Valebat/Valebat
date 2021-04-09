//
//  DeathComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 18/3/21.
//

import GameplayKit

protocol OnDeathObservers {
    func onDeath()
}

class DeathComponent: BaseComponent {
    var onDeathObservers = [ObjectIdentifier: OnDeathObservers]()
    func onDeath() {
        onDeathObservers.values.forEach({ $0.onDeath() })
        if let entity = self.baseEntity {
            entity.entityManager?.objectiveManager.incrementKillCounter()
            entity.entityManager?.remove(entity)
        }
    }
}
