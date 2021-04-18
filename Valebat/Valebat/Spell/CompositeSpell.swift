//
//  CompositeSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class CompositeSpell: Spell {
    var damageTypes: [BasicType]
    
    class var description: String {
        "composite"
    }

    required init(at level: Double) throws {
        self.damageTypes = []
        super.init()
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
    }
}
