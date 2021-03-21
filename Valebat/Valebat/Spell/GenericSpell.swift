//
//  GenericSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//

class GenericSpell: Spell {

    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) throws {
        if element.type != .generic {
            throw SpellErrors.wrongElementTypeError
        }
        self.element = element
        self.damageTypes.insert(.pure)
    }

    init(at level: Double) throws {
        try self.element = Element(with: .generic, at: level)
        self.damageTypes.insert(.pure)
    }
}
