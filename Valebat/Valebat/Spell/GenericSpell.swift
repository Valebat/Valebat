//
//  GenericSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//

class GenericSpell: Spell {

    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) {
        if element.type != .generic {
            WrongElementTypeException().raise()
        }
        self.element = element
        self.damageTypes.insert(.pure)
    }

    init(at level: Double) {
        self.element = Element(with: .generic, at: level)
        self.damageTypes.insert(.pure)
    }
}
