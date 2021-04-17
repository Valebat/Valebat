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
        self.effects.append(SpellEffectComponent.self)
        self.effectParams.append([])
        self.movement = ProjectileMotionComponent.self
    }

    override class var description: String {
        "earth fire"
    }
}
