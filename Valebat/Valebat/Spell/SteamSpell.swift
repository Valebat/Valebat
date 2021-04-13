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
        self.effects = [SpellSpawnOnHitComponent.self]
        let spawnTypeParam: [Any] = [BasicType.water, self.level / 2]
        self.effectParams = [spawnTypeParam]
    }

    override class var description: String {
        "fire water"
    }
}
