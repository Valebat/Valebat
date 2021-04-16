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

//    func fetchRooms(completed: @escaping () -> Void) {
//        print("Fetch called.")
//        fdb.collection("rooms").getDocuments { (querySnapshot, error) in
//            if let err = error {
//                print("Database error: \(err).")
//            } else {
//                self.roomCodes = querySnapshot!.documents.compactMap { (queryDocumentSnapshot) -> String? in
//                    let data = queryDocumentSnapshot.data()
//                    return data["code"] as? String ?? ""
//                }
//                print("after roomCodes")
//                print(self.roomCodes)
//                completed()
//            }
//        }
//    }

    func fetchRooms() {
        fdb.collection("rooms").getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Database error: \(err).")
            } else {
                self.roomCodes = querySnapshot!.documents.compactMap { (queryDocumentSnapshot) -> String? in
                    let data = queryDocumentSnapshot.data()
                    return data["code"] as? String ?? ""
                }
                print("after roomCodes")
                print(self.roomCodes)
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

    func createNewRoom() -> Room {
        print("Create new called.")

        let group = DispatchGroup()
        print("Before enter.")
        group.enter()
        print("After enter.")

        DispatchQueue.global(qos: .default).async {
            print("In async.")
            self.fdb.collection("rooms").getDocuments { (querySnapshot, error) in
                print("In collection.")
                if let err = error {
                    print("Database error: \(err).")
                } else {
                    self.roomCodes = querySnapshot!.documents.compactMap { (queryDocumentSnapshot) -> String? in
                        let data = queryDocumentSnapshot.data()
                        return data["code"] as? String ?? ""
                    }
                    print("after roomCodes")
                    print(self.roomCodes)
                    group.leave()
                }
            }
        }

        group.wait()

        print("End create new.")
        return createRoom()
    }

    private func createRoom() -> Room {
        print("Create called.")
        var room = Room()

        while roomCodes.contains(room.code) {
            room = Room()
        }

        addRoomToDatabase(room)
        roomCodes.append(room.code)

        print("Codes:")
        print(roomCodes)
        print("End create.")
        return room
    }

    /// Currently not deleting from DB.
    func removeRoom(_ room: Room) {
        _ = roomCodes.filter { $0 != room.code }
    }
}
