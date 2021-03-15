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
    
    func populateTypeCombinationTable() {
        for type in ElementType.allCases {
            SpellManager.typeCombinationTable[type] = [ElementType: ElementType]()
        }
    }
    
    func addCombinations() {
        SpellManager.typeCombinationTable[.fire]?[.water] = .steam
        SpellManager.typeCombinationTable[.fire]?[.earth] = .magma
        SpellManager.typeCombinationTable[.water]?[.earth] = .mud
    }
    
    func makeSpell(with element: Element) -> Spell {
        return SingleElementSpell(with: element)
    }
    
    func combineElements(lhs: Element, rhs: Element) -> Spell {
        let combinedLevel = combineLevel(lhs: lhs.level, rhs: rhs.level)
        if let combinedType = SpellManager.typeCombinationTable[lhs.type]?[rhs.type] {
            return associatedSpell(for: combinedType, at: combinedLevel)
        } else {
            return GenericSpell(at: combinedLevel)
        }
    }
    
    func combine(elements: Set<Element>) -> Spell {
        if elements.isEmpty {
            return GenericSpell(at: 0)
        } else if elements.count == 1 {
            let element = elements.first ?? Element(with: .generic, at: 0)
            return associatedSpell(for: element.type, at: element.level)
        } else {
            var set = elements
            guard let minElement = elements.min(by: {$0.type.rawValue < $1.type.rawValue}) else {
                return GenericSpell(at: 0)
            }
            set.remove(minElement)
            guard let secondMinElement = set.min(by: {$0.type.rawValue < $1.type.rawValue}) else {
                return associatedSpell(for: minElement.type, at: minElement.level)
            }
            let combinedLevel = combineLevel(lhs: minElement.level, rhs: secondMinElement.level)
            if let combinedType = SpellManager.typeCombinationTable[minElement.type]?[secondMinElement.type] {
                let combinedElement = Element(with: combinedType, at: combinedLevel)
                set.insert(combinedElement)
                return combine(elements: set)
            } else {
                return GenericSpell(at: elements.map({$0.level}).reduce(0, +))
            }
        }
    }
    
    func combineLevel(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }
    
    func associatedSpell(for type: ElementType, at level: Double) -> Spell {
        switch type {
        case .fire, .water, .earth:
            return SingleElementSpell(with: Element(with: type, at: level))
        case .generic:
            return GenericSpell(at: level)
        case .steam:
            return SteamSpell(at: level)
        case .magma:
            return MagmaSpell(at: level)
        case .mud:
            return MudSpell(at: level)
        }
    }
    
}
