//
//  MudSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class MudSpell: Spell {
    let element: Element

    required init(with element: Element) {
        if element.type != .mud {
            WrongElementTypeException().raise()
        }
        self.element = element
    }

    init(at level: Double) {
        self.element = Element(with: .mud, at: level)
    }
}
