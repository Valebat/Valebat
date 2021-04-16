//
//  Username.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestoreSwift

class Username: Identifiable, Codable {
    @DocumentID var idx: String? = UUID().uuidString
    let username: String

    init(_ username: String) {
        self.username = username
    }
}
