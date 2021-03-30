//
//  Resistances.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation
import UIKit

class DamageMultipliers {
    var multiplierValues = [BasicType: CGFloat]()

    init() {
        for type in BasicType.allCases {
            multiplierValues[type] = 1.0
        }
    }

    init(water: CGFloat, earth: CGFloat, fire: CGFloat, pure: CGFloat) {
        multiplierValues[.water] = water
        multiplierValues[.earth] = earth
        multiplierValues[.fire] = fire
        multiplierValues[.pure] = pure
    }

    static func defaultWaterResist() -> DamageMultipliers {
        DamageMultipliers(water: 1.0, earth: 1.5, fire: 0.75, pure: 1)
    }
    static func defaultFireResist() -> DamageMultipliers {
        DamageMultipliers(water: 1.5, earth: 0.75, fire: 1.0, pure: 1)
    }
    static func defaultEarthResist() -> DamageMultipliers {
        DamageMultipliers(water: 0.75, earth: 1.0, fire: 1.5, pure: 1)
    }

    func getFinalDamage(damages: [BasicType: CGFloat]) -> CGFloat {
        var finalDamage: CGFloat = 0.0
        for (type, value) in damages {
            finalDamage += (multiplierValues[type] ?? 1.0) * value
        }
        return finalDamage
    }
}
