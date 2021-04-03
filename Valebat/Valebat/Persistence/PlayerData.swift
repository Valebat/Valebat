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
        let playerStats = PlayerStatsManager.getInstance()
        playerStats.level = level
        playerStats.elements = getElementDictionary()
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
