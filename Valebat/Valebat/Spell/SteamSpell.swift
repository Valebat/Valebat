//
//  SteamSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SteamSpell: Spell {
    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) throws {
        if element.type != .steam {
            throw SpellErrors.wrongElementTypeError
        }
        self.element = element
        self.damageTypes.insert(.fire)
        self.damageTypes.insert(.water)
    }

    init(at level: Double) throws {
        try self.element = Element(with: .steam, at: level)
        self.damageTypes.insert(.fire)
        self.damageTypes.insert(.water)
    }
}
