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
        do {
            try self.room = dbManager.fetchDocument(from: "rooms", where: "code", equals: roomCode)?
                .data(as: Room.self)
            completed()
        } catch {
            print("Failed to fetch room.")
            self.room = nil
        }
    }

    private func setRoomPlayer(_ room: Room, completed: () -> Void) {
        dbManager.set(data: [ "players": room.players ], in: "rooms", for: room.idx!)
        completed()
    }

    private func setHostPlayer(_ room: Room, with username: String, completed: () -> Void) {
        room.hostId = username
        dbManager.set(data: [ "hostId": username ], in: "rooms", for: room.idx!)
        dbManager.set(data: [ "players": room.players ], in: "rooms", for: room.idx!)
        completed()
    }

    func startRoom(completed: () -> Void) {
        guard let room = self.room else {
            return
        }
        dbManager.set(data: [ "started": true ], in: "rooms", for: room.idx!)
        completed()
    }
}
