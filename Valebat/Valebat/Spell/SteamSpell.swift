//
//  SteamSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SteamSpell: Spell {
    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) {
        if element.type != .steam {
            WrongElementTypeException().raise()
        }
        self.element = element
        self.damageTypes.insert(.fire)
        self.damageTypes.insert(.water)
    }

    init(at level: Double) {
        self.element = Element(with: .steam, at: level)
        self.damageTypes.insert(.fire)
        self.damageTypes.insert(.water)
    }
}
