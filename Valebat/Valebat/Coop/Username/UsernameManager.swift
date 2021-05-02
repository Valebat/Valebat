//
//  UsernameManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class UsernameManager {
    private var usernames: [String] = []
    var username: Username?
    var dbManager = DatabaseManager()

    func fetchUsernames(completed: @escaping () -> Void) {
        dbManager.fetchDocuments(from: "usernames", completed: { (querySnapshot) in
            self.usernames = querySnapshot.compactMap { (queryDocumentSnapshot) -> String? in
                let data = queryDocumentSnapshot.data()
                return data["username"] as? String ?? ""
            }
            completed()
        })
    }

    func addUsernameToDatabase(_ username: Username) {
        do {
            _ = try dbManager.add(document: username, to: "usernames")
        } catch {
            print(error)
        }
    }

    func setupUser(completed: @escaping () -> Void) {
        fetchUsernames { [self] in
            createUsername()
            completed()
        }
    }

    private func createUsername() {
        var username = Username()

        while usernames.contains(username.username) {
            username = Username()
        }

        addUsernameToDatabase(username)
        usernames.append(username.username)

        self.username = username
    }

    /// Currently not deleting from DB.
    func removeUsername(_ uname: String) {
        _ = usernames.filter { $0 != uname }
    }
}
