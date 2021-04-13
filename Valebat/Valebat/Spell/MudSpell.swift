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
        self.effects = [SpellHitComponent.self]
        self.effectParams = [[]]
    }

    override class var description: String {
        "earth water"
    }

}
