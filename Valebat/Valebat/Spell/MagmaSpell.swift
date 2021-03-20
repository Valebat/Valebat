//
//  MagmaSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MagmaSpell: Spell {
    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) throws {
        if element.type != .magma {
            throw SpellErrors.wrongElementTypeError
        }
        self.element = element
        self.damageTypes.insert(.earth)
        self.damageTypes.insert(.fire)
    }

    init(at level: Double) throws {
        try self.element = Element(with: .magma, at: level)
        self.damageTypes.insert(.earth)
        self.damageTypes.insert(.fire)
    }
}
