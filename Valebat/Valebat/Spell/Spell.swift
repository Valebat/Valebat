//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

protocol Spell {
    var level: Double { get }
    var effects: [SpellHitComponent.Type] { get }
    var effectParams: [[Any]] { get }
}
