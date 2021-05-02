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
            if !(entity is PlayerEntity) {
                entity.entityManager?.currentSession?.objectiveManager.incrementCounter(.kills)
            }
            entity.entityManager?.remove(entity)
        }
    }
}
