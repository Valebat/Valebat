//
//  MagmaSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MagmaSpell: CompositeSpell {

    let level: Double
    var damageTypes = [BasicType]()

    required init(at level: Double) throws {
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
        self.damageTypes.append(.earth)
        self.damageTypes.append(.fire)
    }

    static var description: String {
        "earth fire"
    }
}
