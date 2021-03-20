//
//  ElementQueue.swift
//  Valebat
//
//  Created by Sreyans Sipani on 12/3/21.
//

class SpellManager {

    static var typeCombinationTable = [ElementType: [ElementType: ElementType]]()

    init() {
        populateTypeCombinationTable()
        addCombinations()
    }

    init(customTable: [ElementType: [ElementType: ElementType]]) {
        SpellManager.typeCombinationTable = customTable
    }

    func populateTypeCombinationTable() {
        for type in ElementType.allCases {
            SpellManager.typeCombinationTable[type] = [ElementType: ElementType]()
            SpellManager.typeCombinationTable[type]?[type] = type // Default types for same element combinations
        }
    }

    func addCombinations() {
        SpellManager.typeCombinationTable[.fire]?[.water] = .steam
        SpellManager.typeCombinationTable[.fire]?[.earth] = .magma
        SpellManager.typeCombinationTable[.water]?[.earth] = .mud
    }

    func combineElements(lhs: Element, rhs: Element) throws -> Spell {
        let minElementType = lhs.type.rawValue < rhs.type.rawValue ? lhs.type : rhs.type
        let maxElementType = lhs.type.rawValue >= rhs.type.rawValue ? lhs.type : rhs.type
        let combinedLevel = combineLevel(lhs: lhs.level, rhs: rhs.level)
        if let combinedType = SpellManager.typeCombinationTable[minElementType]?[maxElementType] {
            print(combinedType)
            return try associatedSpell(for: combinedType, at: combinedLevel)
        } else {
            return try GenericSpell(at: combinedLevel)
        }
    }

    func combine(elements: [Element]) throws -> Spell {
        if elements.isEmpty {
            return try GenericSpell(at: 1)
        } else if elements.count == 1 {
            let element = try elements.first ?? Element(with: .generic, at: 1)
            return try associatedSpell(for: element.type, at: element.level)
        } else if elements.count == 2 {
            var set = elements
            guard let element1 = elements.first else {
                return try GenericSpell(at: 1)
            }
            set.removeFirst()
            guard let element2 = set.first else {
                return try associatedSpell(for: element1.type, at: element1.level)
            }
            return try combineElements(lhs: element1, rhs: element2)
        } else {
            var list = elements
            guard let minElement = elements.min(by: {$0.type.rawValue < $1.type.rawValue}),
                  let minIndex = list.firstIndex(of: minElement) else {
                return try GenericSpell(at: 1)
            }
            list.remove(at: minIndex)
            guard let secondMinElement = list.min(by: {$0.type.rawValue < $1.type.rawValue}) else {
                return try associatedSpell(for: minElement.type, at: minElement.level)
            }
            let combinedLevel = combineLevel(lhs: minElement.level, rhs: secondMinElement.level)
            if let combinedType = SpellManager.typeCombinationTable[minElement.type]?[secondMinElement.type] {
                let combinedElement = try Element(with: combinedType, at: combinedLevel)
                list.append(combinedElement)
                return try combine(elements: list)
            } else {
                return try GenericSpell(at: elements.map({$0.level}).reduce(0, +))
            }
        }
    }

    func combineLevel(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }

    func associatedSpell(for type: ElementType, at level: Double) throws -> Spell {
        switch type {
        case .fire, .water, .earth:
            return try SingleElementSpell(with: Element(with: type, at: level))
        case .generic:
            return try GenericSpell(at: level)
        case .steam:
            return try SteamSpell(at: level)
        case .magma:
            return try MagmaSpell(at: level)
        case .mud:
            return try MudSpell(at: level)
        }
    }

}
