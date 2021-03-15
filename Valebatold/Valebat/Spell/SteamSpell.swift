//
//  SteamSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SteamSpell: Spell {
    let element: Element
    
    required init(with element: Element) {
        if element.type != .steam {
            WrongElementTypeException().raise()
        }
        self.element = element
    }
    
    init(at level: Double) {
        self.element = Element(with: .steam, at: level)
    }
}
