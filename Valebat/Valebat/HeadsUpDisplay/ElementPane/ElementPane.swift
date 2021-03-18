//
//  ElementPane.swift
//  Valebat
//
//  Created by Zhang Yifan on 15/3/21.
//

import SpriteKit

class ElementPane: SKNode {
    var elementQueueArray: [ElementType] = []
    var elementQueue: ElementQueue
    var elementSelection: ElementSelection

    override init() {
        self.elementQueue = ElementQueue()
        self.elementSelection = ElementSelection()
        super.init()

        self.addChild(elementQueue)
        self.addChild(elementSelection)
        elementSelection.elementPane = self
        self.zPosition = HUDConstants.elementPaneZPosition
    }

    func setNewElement(elementType: ElementType) {
        if elementQueueArray.count == HUDConstants.elementQueueLength {
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