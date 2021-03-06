//
//  DamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class DamageComponent: BaseComponent, ContactObserver {
    var damageValues = [BasicType: CGFloat]()

    init(water: CGFloat, earth: CGFloat, fire: CGFloat, pure: CGFloat) {
        damageValues[.water] = water
        damageValues[.earth] = earth
        damageValues[.fire] = fire
        damageValues[.pure] = pure
        super.init()
    }

    func contact(with entity: BaseEntity, seconds: TimeInterval) {
        return
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

    init(damage: CGFloat, type: BasicType) {
        damageValues[type] = damage
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func damageValueFraction(fraction: CGFloat) -> [BasicType: CGFloat] {
        var damageValuesFraction = [BasicType: CGFloat]()
        for (type, value) in damageValues {
            damageValuesFraction[type] = value * fraction
        }
        return damageValuesFraction
    }
}
