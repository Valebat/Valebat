//
//  SingleElementSpell.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class SingleElementSpell: Spell {

    let element: Element

    static var multiplier = [ElementType: [ElementType: Double]]()

    required init(with element: Element) {
        if !element.type.isSingle {
            WrongElementTypeException().raise()
        }
        self.element = element
        populateMultiplier()
        makeMultiplier()
    }

    func populateMultiplier() {
        for type in ElementType.allCases {
            if type.isSingle {
                SingleElementSpell.multiplier[type] = [ElementType: Double]()
            }
        }
    }

    func makeMultiplier() {
        SingleElementSpell.multiplier[.fire]?[.water] = 0.5
        SingleElementSpell.multiplier[.fire]?[.earth] = 1.3
        SingleElementSpell.multiplier[.water]?[.earth] = 0.8
        // Add for composite elements as well?
    }

    func getDamageMultiplier(for type: ElementType) -> Double {
        return SingleElementSpell.multiplier[self.element.type]?[type] ?? 1 * self.element.level
    }
}
