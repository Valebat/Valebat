//
//  DPSDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class DPSDamageComponent: DamageComponent, ContactAllObserver {
    func contactDidBegin(with entity: GKEntity) {
        currentlyOverlappingEntities.insert(entity)
    }

    func contactDidEnd(with entity: GKEntity) {
        currentlyOverlappingEntities.remove(entity)
    }

    var currentlyOverlappingEntities = Set<GKEntity>()

    override func update(deltaTime seconds: TimeInterval) {
        currentlyOverlappingEntities.compactMap({ $0.component(ofType: HealthComponent.self) })
            .forEach({ $0.takeDamage(damages: damageValueFraction(fraction: CGFloat(seconds)))})
    }
    override func didAddToEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactBeginObservers[ObjectIdentifier(self)] = self
        entity?.component(ofType: PhysicsComponent.self)?.contactEndObservers[ObjectIdentifier(self)] = self

        super.didAddToEntity()
    }
    override func willRemoveFromEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactBeginObservers
            .removeValue(forKey: ObjectIdentifier(self))
        entity?.component(ofType: PhysicsComponent.self)?.contactEndObservers
            .removeValue(forKey: ObjectIdentifier(self))
        super.willRemoveFromEntity()
    }
}
