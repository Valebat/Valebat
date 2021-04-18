//
//  Username.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestoreSwift

class Username: Identifiable, Codable {
    @DocumentID var idx: String?
    let username: String

    init() {
        let username: String = UsernameGenerator.randomUsername(length: 6)
        self.idx = username
        self.username = username
    }
}
