//
//  Element.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class Element: Hashable {

    let type: ElementType
    let level: Double

    init(with type: ElementType, at level: Double) throws {
        self.type = type
        if level < 1 {
            throw SpellErrors.invalidLevelError
        }
        self.level = level
    }

    static func == (lhs: Element, rhs: Element) -> Bool {
        return lhs.type == rhs.type && lhs.level == rhs.level
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.type)
        hasher.combine(self.level)
    }
}
