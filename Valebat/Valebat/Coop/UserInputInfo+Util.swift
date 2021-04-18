//
//  UserInputInfo+Util.swift
//  Valebat
//
//  Created by Zhang Yifan on 18/4/21.
//

extension UserInputInfo {
    func convertToDBRequest(playerId: String, roomId: String) -> [String: Any] {
        let elements = elementQueueArray.map { $0.rawValue }
        let updates = [
            "playerInput/\(roomId)/\(playerId)/mvmtAngular": movementJoystickAngular,
            "playerInput/\(roomId)/\(playerId)/mvmtVelocity": movementJoystickVelocity,
            "playerInput/\(roomId)/\(playerId)/spellAngular": spellJoystickAngular,
            "playerInput/\(roomId)/\(playerId)/spellEnd": spellJoystickEnd,
            "playerInput/\(roomId)/\(playerId)/spellMove": spellJoystickMoved,
            "playerInput/\(roomId)/\(playerId)/elements": elements
          ] as [String: Any]
        return updates
    }
}
