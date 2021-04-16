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

    func fetchRooms() {
        fdb.collection("rooms").addSnapshotListener { (querySnapsnot, _) in
            guard let documents = querySnapsnot?.documents else {
                print("Database error: no documents found.")
                return
            }

            self.roomCodes = documents.compactMap { (queryDocumentSnapshot) -> String? in
                let data = queryDocumentSnapshot.data()

                return data["code"] as? String ?? ""
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

    func createRoom() -> Room {
        print("before fetch")
        fetchRooms()
        print("after fetch")

        var room = Room()

        while roomCodes.contains(room.code) {
            room = Room()
        }

        addRoomToDatabase(room)
        roomCodes.append(room.code)

        print("Codes:")
        print(roomCodes)
        return room
    }

    func removeRoom(_ room: Room) {
        _ = roomCodes.filter { $0 != room.code }
    }
}
