//
//  SteamSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SteamSpell: CompositeSpell {

    required init(at level: Double) throws {
        try super.init(at: level)
        self.damageTypes.append(.water)
        self.damageTypes.append(.fire)
        self.effects.append(SpellSpawnOnHitComponent.self)
        let spawnTypeParam: [Any] = [Spell.buildEndAnimation(), 0.05, BasicType.water, 1/2]
        self.effectParams.append(spawnTypeParam)
    }

    override class var description: String {
        "fire water"
    }
}
