//
//  UserInputInfo+Util.swift
//  Valebat
//
//  Created by Zhang Yifan on 18/4/21.
//

import CoreGraphics

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

    convenience init?(data: [String: Any]) {
        guard let mvmtAngular = data["mvmtAngular"] as? Float,
              let mvmtVelocityX = data["mvmtVelocityX"] as? Float,
              let mvmtVelocityY = data["mvmtVelocityY"] as? Float,
              let spellAngular = data["spellAngular"] as? Float,
              let spellEnd = data["spellEnd"] as? Bool,
              let spellMove = data["spellMove"] as? Bool else {
            return nil
        }

        var elementsArray = [BasicType]()
        if let elements = data["elements"] as? [String: String] {
            for (_, elem) in elements {
                guard let elemType = BasicType(rawValue: elem) else {
                    continue
                }
                elementsArray.append(elemType)
            }
        }
        self.init()
        self.movementJoystickAngular = CGFloat(mvmtAngular)
        self.movementJoystickVelocity = CGPoint(x: CGFloat(mvmtVelocityX),
                                                y: CGFloat(mvmtVelocityY))
        self.spellJoystickAngular = CGFloat(spellAngular)
        self.spellJoystickEnd = spellEnd
        self.spellJoystickMoved = spellMove
        if elementsArray.count > 0 {
            self.elementQueueArray = elementsArray
        }
    }
}
