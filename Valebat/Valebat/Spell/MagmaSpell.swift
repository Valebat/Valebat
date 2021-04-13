//
//  MagmaSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MagmaSpell: CompositeSpell {

    required init(at level: Double) throws {
        try super.init(at: level)
        self.damageTypes.append(.earth)
        self.damageTypes.append(.fire)
        self.effects.append(SpellExplodeOnHitComponent.self)
        self.effectParams.append([Spell.buildEndAnimation(), 0.05])
        self.effects.append(SpellSpawnOnShootComponent.self)
        self.effectParams.append([BasicType.earth, self.level/2])
    }

    override class var description: String {
        "earth fire"
    }
}
