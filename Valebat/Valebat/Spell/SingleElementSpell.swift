//
//  SingleElementSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SingleElementSpell: Spell {

    let element: Element
    var damageTypes = Set<DamageType>()

    required init(with element: Element) throws {
        if !element.type.isSingle {
            throw SpellErrors.wrongElementTypeError
        }
        self.element = element
        if let damageType = element.type.associatedDamageType {
            self.damageTypes.insert(damageType)
        }
    }
}
