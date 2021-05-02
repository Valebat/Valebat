//
//  RoomManager.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

class RoomManager {
    var roomCodes: [String] = []
    var room: Room?
    var dbManager = DatabaseManager()

    func fetchRooms(completed: @escaping () -> Void) {
        dbManager.fetchDocuments(from: "rooms", completed: { (result) in
            self.roomCodes = result.compactMap { (queryDocumentSnapshot) -> String? in
                let data = queryDocumentSnapshot.data()
                return data["code"] as? String ?? ""
            }
            completed()
        })

    }

    func addRoomToDatabase(_ room: Room) {
        do {
            _ = try dbManager.add(document: room, to: "rooms")
        } catch {
            print(error)
        }
    }

    func setupNewRoom(completed: @escaping () -> Void) {
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
