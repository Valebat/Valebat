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
}
