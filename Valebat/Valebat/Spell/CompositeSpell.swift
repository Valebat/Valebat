//
//  CompositeSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

protocol CompositeSpell: Spell {
    var level: Double { get }
    var damageTypes: [BasicType] { get }
    static var description: String { get }

    init(at level: Double) throws
}
