//
//  GenericSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//

class GenericSpell: CompositeSpell {

    let level: Double
    var damageTypes = [BasicType]()
    var effects = [SpellHitComponent.Type]()
    var effectParams = [[Any]]()

    required init(at level: Double) throws {
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
        self.damageTypes.append(.pure)
        self.effects.append(SpellHitComponent.self)
    }

    init(at level: Double, from basicTypes: [BasicType]) throws {
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
        self.damageTypes.append(contentsOf: basicTypes)
        self.effects.append(SpellHitComponent.self)
    }

    static var description: String {
        "pure"
    }
}
