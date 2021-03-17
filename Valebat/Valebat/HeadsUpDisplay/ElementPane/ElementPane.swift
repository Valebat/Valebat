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

    override init() {
        self.elementQueue = ElementQueue()
        super.init()

        self.addChild(elementQueue)
        self.zPosition = HUDConstants.elementPaneZPosition
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
