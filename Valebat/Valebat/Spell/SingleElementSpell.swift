//
//  SingleElementSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SingleElementSpell: Spell {

    let damageType: BasicType

    init(with element: Element) {
        self.damageType = element.type
        super.init()
        self.level = element.level
        self.effects.append(SpellExplodeOnHitComponent.self)
        self.effectParams.append([Spell.buildEndAnimation(), 0.05])
    }
}
