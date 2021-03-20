//
//  Element.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

class Element: Hashable {

    let type: ElementType
    let level: Double

    init(with type: ElementType, at level: Double) {
        self.type = type
        if level < 1 {
            InvalidLevelException().raise()
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
