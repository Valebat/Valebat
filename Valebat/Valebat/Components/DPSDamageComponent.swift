//
//  DPSDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class DPSDamageComponent: DamageComponent, ContactAllNotifiable {
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
}
