//
//  DPSDamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit

class DPSDamageComponent: DamageComponent {

    override func contact(with entity: GKEntity, seconds: TimeInterval) {
        entity.component(ofType: DamageTakerComponent.self)?
            .takeDamage(damages: damageValueFraction(fraction: CGFloat(seconds)), soundEffect: .laser)
    }
}
