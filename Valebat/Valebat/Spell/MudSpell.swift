//
//  MudSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MudSpell: Spell {
    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) {
        if element.type != .mud {
            WrongElementTypeException().raise()
        }
        self.element = element
        self.damageTypes.insert(.earth)
        self.damageTypes.insert(.water)
    }

    init(at level: Double) {
        self.element = Element(with: .mud, at: level)
        self.damageTypes.insert(.earth)
        self.damageTypes.insert(.water)
    }
}
