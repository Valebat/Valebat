//
//  SteamSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SteamSpell: CompositeSpell {

    let level: Double
    var damageTypes = [BasicType]()
    let effects: [SpellHitComponent.Type]
    let effectParams: [[Any]]

    required init(at level: Double) throws {
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
        self.damageTypes.append(.water)
        self.damageTypes.append(.fire)
        self.effects = [SpellSpawnOnHitComponent.self]
        let spawnTypeParam: [Any] = [BasicType.water, self.level / 2]
        self.effectParams = [spawnTypeParam]
    }

    static var description: String {
        "fire water"
    }
}
