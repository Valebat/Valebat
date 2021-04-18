//
//  ElementQueue.swift
//  Valebat
//
//  Created by Sreyans Sipani on 12/3/21.
//
import Foundation

class SpellManager {
    private static var combinationTable = [String: CompositeSpell.Type]()

    init() {
        populatecombinationTable()
    }

    private func subscribers<T>(of protocol: T.Type) -> [ClassInfo] {
        var subscribersList = [ClassInfo]()

        var count = UInt32(0)
        guard let classListPointer = objc_copyClassList(&count) else {
            return []
        }

        let classInfoList = UnsafeBufferPointer(start: classListPointer,
                                                count: Int(count)).map(ClassInfo.init)

        for classInfo in classInfoList {
            // skip native Swift and Foundation classes, to do not crash
            if classInfo?.classNameFull.components(separatedBy: ".").count == 1 {
                continue
            }
            if let info = classInfo, info.classObject is T {
                subscribersList.append(info)
            }
        }
        return subscribersList
    }

    private func populatecombinationTable() {
        for subscriber in subscribers(of: CompositeSpell.Type.self) {
            if let spellClass = subscriber.classObject as? CompositeSpell.Type {
                SpellManager.combinationTable[spellClass.description] = spellClass
            }
        }
    }

    private func combineLevels(levels: [Double]) -> Double {
        return levels.reduce(0, +)
    }

    private func reduceElements(elements: [Element]) throws -> [Element] {
        let groupedElements = Dictionary(grouping: elements, by: { $0.type })
        var reducedElements = [Element]()
        for (elementType, sameElementList) in groupedElements {
            let combinedLevel = sameElementList.map({ $0.level }).reduce(0, +)
            reducedElements.append(try Element(with: elementType, at: combinedLevel))
        }
        return reducedElements
    }

    func combine(elements: [Element]) throws -> Spell {
        let reducedElements = try reduceElements(elements: elements)
        if reducedElements.isEmpty {
            return try GenericSpell(at: 1)
        } else if reducedElements.count == 1 {
            let element = try reducedElements.first ?? Element(with: .pure, at: 1)
            return SingleElementSpell(with: element)
        } else {
            let typeStrings = reducedElements.map { $0.type.rawValue }
            let description = typeStrings.sorted().joined(separator: " ")
            let combinedLevel = combineLevels(levels: elements.map { $0.level })
            if let combinedType = SpellManager.combinationTable[description] {
                return try combinedType.init(at: combinedLevel)
            } else {
                return try GenericSpell(at: combinedLevel)
            }
        }
    }
}
