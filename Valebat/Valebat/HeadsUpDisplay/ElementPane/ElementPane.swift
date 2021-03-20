//
//  ElementPane.swift
//  Valebat
//
//  Created by Zhang Yifan on 15/3/21.
//

import SpriteKit

class ElementPane: SKNode {
    private(set) var elementQueueArray: [ElementType] = []
    private(set) var elementQueue: ElementQueue
    private(set) var elementSelection: ElementSelection
    private(set) var arrayCount: Int = 1

    convenience init(count: Int = HUDConstants.elementQueueLength) {
        self.init()
        if count > 0 {
            arrayCount = count
        }
    }

    private override init() {
        self.elementQueue = ElementQueue()
        self.elementSelection = ElementSelection()
        super.init()

        self.addChild(elementQueue)
        self.addChild(elementSelection)
        elementSelection.elementPane = self
        self.zPosition = HUDConstants.elementPaneZPosition
    }

    func setNewElement(elementType: ElementType) {
        if elementQueueArray.count == arrayCount {
            elementQueueArray.removeFirst()
        }
        elementQueueArray.append(elementType)
        elementQueue.renderElementsInQueue(selectedElements: elementQueueArray)
    }

    func clearElementQueue() {
        elementQueueArray.removeAll()
        elementQueue.renderElementsInQueue(selectedElements: elementQueueArray)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
