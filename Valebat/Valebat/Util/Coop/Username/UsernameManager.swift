//
//  UsernameManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestore
// import FirebaseFirestoreSwift

class UsernameManager {
    private var fdb = Firestore.firestore()
    private var usernames: [String] = []
    var username: Username?

    func fetchUsernames(completed: @escaping () -> Void) {
        fdb.collection("usernames").getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Database error: \(err).")
            } else {
                self.usernames = querySnapshot!.documents.compactMap { (queryDocumentSnapshot) -> String? in
                    let data = queryDocumentSnapshot.data()
                    return data["username"] as? String ?? ""
                }
                completed()
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
