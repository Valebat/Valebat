//
//  Element.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class Element: Equatable {

    let type: BasicType
    let level: Double

    init(with type: BasicType, at level: Double) throws {
        self.type = type
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
    }

    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.type == rhs.type && lhs.level == rhs.level
    }
}
