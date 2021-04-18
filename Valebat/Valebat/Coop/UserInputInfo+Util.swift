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
            "playerInput/\(roomId)/\(playerId)/mvmtAngular": Float(movementJoystickAngular),
            "playerInput/\(roomId)/\(playerId)/mvmtVelocityX": Float(movementJoystickVelocity.x),
            "playerInput/\(roomId)/\(playerId)/mvmtVelocityY": Float(movementJoystickVelocity.y),
            "playerInput/\(roomId)/\(playerId)/spellAngular": Float(spellJoystickAngular),
            "playerInput/\(roomId)/\(playerId)/spellEnd": spellJoystickEnd,
            "playerInput/\(roomId)/\(playerId)/spellMove": spellJoystickMoved,
            "playerInput/\(roomId)/\(playerId)/elements": elements
          ] as [String: Any]
        return updates
    }

//    func shouldSend() -> Bool {
//        if movementJoystickAngular > 0
//    }
}
