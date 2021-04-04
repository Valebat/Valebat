//
//  CompositeSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

protocol CompositeSpell: Spell {
    var level: Double { get }
    var damageTypes: [BasicType] { get }
    var effects: [SpellHitComponent.Type] { get }
    var effectParams: [[Any]] { get }
    static var description: String { get }

    init(at level: Double) throws
}
