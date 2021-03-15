//
//  MagmaSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MagmaSpell: Spell {
    let element: Element
    
    required init(with element: Element) {
        if element.type != .magma {
            WrongElementTypeException().raise()
        }
        self.element = element
    }
    
    init(at level: Double) {
        self.element = Element(with: .magma, at: level)
    }
}
