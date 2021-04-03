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

    func getElementDictionary() -> [ElementType: Element] {
        var elements: [ElementType: Element] = [:]
        let elementTypes = convertElementStringToEnum()
        do {
            for index in 0..<elementTypes.count {
                try elements.updateValue(Element(with: elementTypes[index], at: elementLevel[index]),
                                         forKey: elementTypes[index])
            }
        } catch SpellErrors.wrongElementTypeError {
            print("Wrong element type was given")
        } catch {
            print("Unexpected error")
        }
        return elements
    }

    func convertToPlayerStats() -> PlayerStats {
        var playerStats = PlayerStats()
        playerStats.level = level
        playerStats.elements = getElementDictionary()
        return playerStats
    }

    private func convertElementStringToEnum() -> [ElementType] {
        var enumArray: [ElementType] = []
        for typeString in elementType {
            switch typeString {
            case "fire":
                enumArray.append(.fire)
            case "earth":
                enumArray.append(.earth)
            case "water":
                enumArray.append(.water)
            default:
                print("invalid element type")
            }
        }
        return enumArray
    }
}
