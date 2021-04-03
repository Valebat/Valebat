//
//  DPSDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class DPSDamageComponent: DamageComponent, ContactObserver {

    func contact(with entity: GKEntity, seconds: TimeInterval) {
        entity.component(ofType: DamageTakerComponent.self)?.takeDamage(damages: damageValueFraction(fraction: CGFloat(seconds)))
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
