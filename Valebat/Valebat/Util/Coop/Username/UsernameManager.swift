//
//  UsernameManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class UsernameManager {
    private var fdb = Firestore.firestore()
    private var usernames: [String] = []

    func fetchUsernames() {
        fdb.collection("usernames").addSnapshotListener { (querySnapsnot, _) in
            guard let documents = querySnapsnot?.documents else {
                print("Database error: no documents found.")
                return
            }

            self.usernames = documents.compactMap { (queryDocumentSnapshot) -> String? in
                let data = queryDocumentSnapshot.data()

                return data["username"] as? String ?? ""
            }
        }
    }

    func addUsernameToDatabase(_ username: Username) {
        do {
            _ = try fdb.collection("usernames").addDocument(from: username)
        } catch {
            print(error)
        }
    }

    func createUsername(_ uname: String) -> Bool {
        fetchUsernames()

        if usernames.contains(uname) {
            return false
        }

        let username = Username(uname)

        addUsernameToDatabase(username)

        usernames.append(uname)

        return true
    }

    /// Currently not deleting from DB.
    func removeUsername(_ uname: String) {
        _ = usernames.filter { $0 != uname }
    }
}
