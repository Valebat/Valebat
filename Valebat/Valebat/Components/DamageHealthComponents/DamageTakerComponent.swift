//
//  DamageTakerComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 2/4/21.
//

import Foundation
import GameplayKit

class DamageTakerComponent: BaseComponent {

    var multiplierValues = [BasicType: CGFloat]()

    override init() {
        for type in BasicType.allCases {
            multiplierValues[type] = 1.0
        }
        super.init()
    }

    init(water: CGFloat, earth: CGFloat, fire: CGFloat, pure: CGFloat) {
        multiplierValues[.water] = water
        multiplierValues[.earth] = earth
        multiplierValues[.fire] = fire
        multiplierValues[.pure] = pure
        super.init()
    }

    init(multipliers: [BasicType: CGFloat]) {
        multiplierValues = multipliers
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func defaultWaterResist() -> DamageTakerComponent {
        DamageTakerComponent(water: 1.0, earth: 1.5, fire: 0.75, pure: 1)
    }
    static func defaultFireResist() -> DamageTakerComponent {
        DamageTakerComponent(water: 1.5, earth: 0.75, fire: 1.0, pure: 1)
    }
    static func defaultEarthResist() -> DamageTakerComponent {
        DamageTakerComponent(water: 0.75, earth: 1.0, fire: 1.5, pure: 1)
    }

    func getFinalDamage(damages: [BasicType: CGFloat]) -> CGFloat {
        var finalDamage: CGFloat = 0.0
        for (type, value) in damages {
            finalDamage += (multiplierValues[type] ?? 1.0) * value
        }
        return finalDamage
    }

    func takeDamage(damages: [BasicType: CGFloat]) {
        let damage = getFinalDamage(damages: damages)
        AudioManager.playSound(soundName: "Hit", cooldown: 0.08)
        entity?.component(ofType: HealthComponent.self)?.takeDamage(damage: damage)
    }
}
