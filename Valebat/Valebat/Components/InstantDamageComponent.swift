//
//  InstantDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation
import GameplayKit

class InstantDamageComponent: DamageComponent, ContactBeginNotifiable {

    func contactDidBegin(with entity: GKEntity) {
        if let health = entity.component(ofType: HealthComponent.self) {
            health.takeDamage(damages: damageValues)
        }
        if destroyOnHit {

        }
    }

    var destroyOnHit = true

}
