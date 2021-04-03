//
//  DamageType.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

enum DamageType: String, CaseIterable {
    case water, earth, fire, pure

    var associatedElementType: ElementType {
        switch self {
        case .fire:
            return .fire
        case .water:
            return .water
        case .earth:
            return .earth
        case .pure:
            return .generic
        }
    }
}
