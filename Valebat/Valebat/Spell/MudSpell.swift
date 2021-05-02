//
//  MudSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MudSpell: CompositeSpell {

    required init(at level: Double) throws {
        try super.init(at: level)
        self.damageTypes.append(.earth)
        self.damageTypes.append(.water)
        self.effects.append(SpellExplodeOnHitComponent.self)
        self.effectParams.append([Spell.buildEndAnimation(), 0.05])
        self.effects.append(SpellSpawnOnShootComponent.self)
        self.effectParams.append([BasicType.water, 1/2])
    }

    override class var description: String {
        "earth water"
    }
}
