//
//  Room.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import SpriteKit

class Room: Codable {
    let idx: UUID
    let code: String
    var started: Bool

    init() {
        self.idx = UUID()
        self.code = RoomCodeGenerator.randomString(length: 6)
        self.started = false
    }
}
