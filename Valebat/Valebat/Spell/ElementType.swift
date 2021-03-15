//
//  ElementType.swift
//  Valebat
//
//  Created by Sreyans Sipani on 11/3/21.
//

enum ElementType: Int, CaseIterable {
    // Single Element Spell
    case fire = 0
    case water
    case earth
    case generic

    // Two Element Spell
    case steam
    case magma
    case mud

    // Multiple Element spells

    var isSingle: Bool {
        switch self {
        case .fire, .water, .earth, .generic:
            return true
        default:
            return false
        }
    }
}
