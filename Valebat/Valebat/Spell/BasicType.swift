//
//  DamageType.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation

enum BasicType: String, CaseIterable {
    case water, earth, fire, pure

    var imageName: String {
        rawValue
    }
}
