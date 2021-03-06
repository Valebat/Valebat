//
//  Room.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestoreSwift

class Room: Identifiable, Codable {
    @DocumentID var idx: String?
    var hostId: String?
    let code: String
    var started: Bool
    var players: [String] = []

    init() {
        let roomCode: String = RoomCodeGenerator.randomString(length: 4)
        self.idx = roomCode
        self.code = roomCode
        self.started = false
    }
}
