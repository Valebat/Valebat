//
//  Username.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import SpriteKit

class Username: Codable {
    let idx: UUID
    let username: String

    init(_ username: String) {
        self.idx = UUID()
        self.username = username
    }
}
