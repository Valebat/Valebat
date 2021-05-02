//
//  InstantDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class InstantDamageComponent: DamageComponent {

    var haveDamagedEntity = Set<GKEntity>()
    override func contact(with entity: GKEntity, seconds: TimeInterval) {
        if let damageTaker = entity.component(ofType: DamageTakerComponent.self) {
            if !haveDamagedEntity.contains(entity) {
                damageTaker.takeDamage(damages: damageValues, soundEffect: .hit)
                haveDamagedEntity.insert(entity)
            }
        }

        if let entity = self.entity {
            entity.component(conformingTo: SpellExplodeOnHitComponent.self)?.createEffect()
        }
    }
}
