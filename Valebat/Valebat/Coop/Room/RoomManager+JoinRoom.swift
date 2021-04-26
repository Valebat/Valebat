//
//  RoomManager+JoinRoom.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

extension RoomManager {
    func joinRoom(username: String, isHost: Bool, roomCode: String, completed: @escaping () -> Void) {
        fetchRoom(roomCode: roomCode) { [self] in
            guard let room = self.room else {
                print("Invalid Room.")
                return
            }
            addUserToRoom(username: username, room: room)
            if isHost {
                setHostPlayer(room, with: username) {
                    completed()
                }
            } else {
                setRoomPlayer(room) {
                    completed()
                }
            }
        }
    }

    private func addUserToRoom(username: String, room: Room) {
        room.players.append(username)
    }

    func fetchRoom(roomCode: String, completed: @escaping () -> Void) {
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

    private func setRoomPlayer(_ room: Room, completed: () -> Void) {
        fdb.collection("rooms").document(room.idx!).setData([ "players": room.players ], merge: true)
        completed()
    }

    private func setHostPlayer(_ room: Room, with username: String, completed: () -> Void) {
        room.hostId = username
        fdb.collection("rooms").document(room.idx!).setData([ "hostId": username ], merge: true)
        fdb.collection("rooms").document(room.idx!).setData([ "players": room.players ], merge: true)
        completed()
    }

    func startRoom(completed: () -> Void) {
        guard let room = self.room else {
            return
        }
        fdb.collection("rooms").document(room.idx!).setData([ "started": true ], merge: true)
        completed()
    }
}
