//
//  DamageComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation
import GameplayKit

class DamageComponent: GKComponent {

    var damageValues = [DamageType: CGFloat]()

    init(water: CGFloat, earth: CGFloat, fire: CGFloat, pure: CGFloat) {
        damageValues[.water] = water
        damageValues[.earth] = earth
        damageValues[.fire] = fire
        damageValues[.pure] = pure
        super.init()
    }

    init(damage: CGFloat, type: DamageType) {
        damageValues[type] = damage

        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func damageValueFraction(fraction: CGFloat) -> [DamageType: CGFloat] {
        var damageValuesFraction = [DamageType: CGFloat]()
        for (type, value) in damageValues {
            damageValuesFraction[type] = value * fraction
        }
        return damageValuesFraction
    }
}
