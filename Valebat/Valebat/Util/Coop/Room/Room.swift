//
//  Room.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestoreSwift

class Room: Identifiable, Codable {
    @DocumentID var idx: String? = UUID().uuidString
    let code: String
    var started: Bool

    init() {
        self.code = RoomCodeGenerator.randomString(length: 6)
        self.started = false
    }
}
