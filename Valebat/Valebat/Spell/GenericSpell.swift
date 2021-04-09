//
//  GenericSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//

class GenericSpell: CompositeSpell {

    required init(at level: Double) throws {
        try super.init(at: level)
        self.damageTypes.append(.pure)
        self.effects.append(SpellHitComponent.self)
        self.effectParams.append([])
    }

    init(at level: Double, from basicTypes: [BasicType]) throws {
        try super.init(at: level)
        self.damageTypes.append(contentsOf: basicTypes)
        self.effects.append(SpellHitComponent.self)
        self.effectParams.append([])
    }

    override class var description: String {
        "pure"
    }
}
