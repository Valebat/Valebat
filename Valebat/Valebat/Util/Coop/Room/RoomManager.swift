//
//  RoomManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class RoomManager {
    private var fdb = Firestore.firestore()
    private var roomCodes: [String] = []
    var room: Room?

    func fetchRooms(completed: @escaping () -> Void) {
        fdb.collection("rooms").getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Database error: \(err).")
            } else {
                self.roomCodes = querySnapshot!.documents.compactMap { (queryDocumentSnapshot) -> String? in
                    let data = queryDocumentSnapshot.data()
                    return data["code"] as? String ?? ""
                }
                completed()
            }
        }
    }

    func addRoomToDatabase(_ room: Room) {
        do {
            _ = try fdb.collection("rooms").addDocument(from: room)
        } catch {
            print(error)
        }
    }

    func createNewRoom(completed: @escaping () -> Void) {
        fetchRooms { [self] in
            createRoom()
            completed()
        }
    }

    private func createRoom() {
        var room = Room()

        while roomCodes.contains(room.code) {
            room = Room()
        }

        addRoomToDatabase(room)
        roomCodes.append(room.code)

        self.room = room
    }

    /// Currently not deleting from DB.
    func removeRoom(_ room: Room) {
        _ = roomCodes.filter { $0 != room.code }
    }
}
