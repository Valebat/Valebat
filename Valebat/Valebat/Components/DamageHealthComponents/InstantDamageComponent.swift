//
//  InstantDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class InstantDamageComponent: DamageComponent, ContactObserver {

    func contact(with entity: GKEntity, seconds: TimeInterval) {
        if let damageTaker = entity.component(ofType: DamageTakerComponent.self) {
            damageTaker.takeDamage(damages: damageValues)
        }
        if let entity = self.entity {
            entity.component(conformingTo: SpellHitComponent.self)?.onHit()
        }

    }

    override func didAddToEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactObservers[ObjectIdentifier(self)] = self
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        entity?.component(ofType: PhysicsComponent.self)?.contactObservers
            .removeValue(forKey: ObjectIdentifier(self))
        super.willRemoveFromEntity()
    }

}
