//
//  ElementPane.swift
//  Valebat
//
//  Created by Zhang Yifan on 15/3/21.
//

import SpriteKit

class ElementPane: SKNode {
    private(set) var elementQueue: ElementQueue
    private(set) var elementSelection: ElementSelection
    private(set) var arrayCount: Int = 1

    weak var userInputNode: UserInputNode?

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

    func setNewElement(elementType: BasicType) {
        guard let userInputInfo = userInputNode?.userInputInfo else {
            return
        }
        userInputInfo.setNewElement(elementType: elementType)
        elementQueue.renderElementsInQueue(selectedElements: userInputInfo.elementQueueArray)
    }

    func clearElementQueue() {
        guard let userInputInfo = userInputNode?.userInputInfo else {
            return
        }
        userInputInfo.clearElementQueue()
        elementQueue.renderElementsInQueue(selectedElements: userInputInfo.elementQueueArray)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
