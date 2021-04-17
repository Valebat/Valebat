//
//  RoomManager+JoinRoom.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

extension RoomManager {
    func joinRoom(username: String, roomCode: String, completed: @escaping () -> Void) {
        fetchRoom(roomCode: roomCode) { [self] in
            addUserToRoom(username: username, room: self.room!)
            setRoom(self.room!) {
                completed()
            }
        }
    }

    private func addUserToRoom(username: String, room: Room) {
        room.players.append(username)
    }

    private func fetchRoom(roomCode: String, completed: @escaping () -> Void) {
        fdb.collection("rooms").whereField("code", isEqualTo: roomCode).getDocuments { (querySnapshot, error) in
            if let err = error {
                print("[Fetch Room] Database error: \(err)")
            } else {
                do {
                    self.room = try querySnapshot!.documents.first?.data(as: Room.self)
                } catch {
                    print("Failed to fetch room.")
                    self.room = nil
                }
                completed()
            }
        }
    }

    private func setRoom(_ room: Room, completed: () -> Void) {
        fdb.collection("rooms").document(room.idx!).setData([ "players": room.players ], merge: true)
        completed()
    }
}
