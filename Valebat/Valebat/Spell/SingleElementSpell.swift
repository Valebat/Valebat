//
//  SingleElementSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SingleElementSpell: Spell {

    let level: Double
    let damageType: BasicType
    let effects: [SpellHitComponent.Type]
    let effectParams: [[Any]]

    init(with element: Element) {
        self.level = element.level
        self.damageType = element.type
        self.effects = [SpellHitComponent.self]
        self.effectParams = [[]]
    }
}
