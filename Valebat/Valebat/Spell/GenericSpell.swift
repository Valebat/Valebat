//
//  GenericSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//

class GenericSpell: CompositeSpell {

    let level: Double
    var damageTypes = [BasicType]()

    required init(at level: Double) throws {
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
        self.damageTypes.append(.pure)
    }

    init(at level: Double, from basicTypes: [BasicType]) throws {
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
        self.damageTypes.append(contentsOf: basicTypes)
    }

    static var description: String {
        "pure"
    }
}
