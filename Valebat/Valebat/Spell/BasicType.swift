//
//  BasicType.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation

enum BasicType: String, CaseIterable, Codable {
    case water, earth, fire, pure

    var imageName: String {
        rawValue
    }

    static func getRandomType() -> BasicType {
        let val = Int.random(in: 0 ... 3)
        switch val {
        case 0:
            return .water
        case 1:
            return .earth
        case 2:
            return .fire
        default:
            return .pure
        }
    }
}
