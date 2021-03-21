//
//  InstantDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class InstantDamageComponent: DamageComponent, ContactBeginObserver {

    var contacted = false

    func contactDidBegin(with entity: GKEntity) {
        if contacted {
            return
        }
        if let health = entity.component(ofType: HealthComponent.self) {
            health.takeDamage(damages: damageValues)
            contacted = true
        }
        if destroyOnHit {
            if let entity = self.entity {
                EntityManager.getInstance().remove(entity)
            }
        }
    }

    override func didAddToEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactBeginObservers[ObjectIdentifier(self)] = self
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactBeginObservers
            .removeValue(forKey: ObjectIdentifier(self))
        super.willRemoveFromEntity()
    }
    var destroyOnHit = true

}
