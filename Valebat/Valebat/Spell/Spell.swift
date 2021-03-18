//
//  Spell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

protocol Spell {

    var element: Element { get }
    var damageTypes: Set<DamageType> { get }

    init(with element: Element)
}
