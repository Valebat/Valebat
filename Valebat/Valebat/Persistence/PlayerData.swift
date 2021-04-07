//
//  PlayerData.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

struct PlayerData: Codable {
    var level: Int = 0
    var elementType: [String] = []
    var elementLevel: [Double] = []

    func getElementDictionary() -> [BasicType: Element] {
        var elements: [BasicType: Element] = [:]
        let elementTypes = convertElementStringToEnum()
        do {
            for index in 0..<elementTypes.count {
                try elements.updateValue(Element(with: elementTypes[index],
                                                 at: elementLevel[index]),
                                         forKey: elementTypes[index])
            }
        } catch SpellErrors.wrongBasicTypeError {
            print("Wrong element type was given")
        } catch {
            print("Unexpected error")
        }
        return elements
    }

    func assignPlayerStats() {
        let playerStats = PlayerStats.getInstance()
        playerStats.level = level
        playerStats.elements = getElementDictionary()
    }

    static func convertToPlayerData() -> PlayerData {
        let playerStats = PlayerStats.getInstance()
        var elementType: [String] = []
        var elementLevel: [Double] = []
        for (type, element) in playerStats.elements {
            elementType.append(type.rawValue)
            elementLevel.append(element.level)
        }
        var playerData = PlayerData()
        playerData.level = playerStats.level
        playerData.elementType = elementType
        playerData.elementLevel = elementLevel
        return playerData
    }

    private func convertElementStringToEnum() -> [BasicType] {
        var enumArray: [BasicType] = []
        for typeString in elementType {
            guard let damageType = BasicType(rawValue: typeString) else {
                continue
            }
            enumArray.append(damageType)
        }
        return enumArray
    }
}
