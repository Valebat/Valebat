//
//  ElementQueue.swift
//  Valebat
//
//  Created by Zhang Yifan on 15/3/21.
//

import SpriteKit

class ElementQueue: SKNode {

    var elements: SKNode?

    override init() {
        super.init()
        elements = SKNode()
        if let elements = elements {
            self.addChild(elements)
        }
        elements?.zPosition = HUDConstants.elementQueueZPosition
        initialisedGrids(count: HUDConstants.elementQueueLength)
    }

    func renderElementsInQueue(selectedElements: [ElementType]) {
        elements?.removeAllChildren()
        for (index, elementType) in selectedElements.enumerated() {
            let element = SKSpriteNode(imageNamed: elementType.stringName)
            let elementSize = HUDConstants.elementQueueElementSize
            let gridSize = HUDConstants.elementQueueGridSize
            element.size = elementSize
            let position = CGPoint(x: HUDConstants.elementQueueStartPos.x + CGFloat(index) * gridSize.width,
                                   y: HUDConstants.elementQueueStartPos.y)
            element.position = position
            elements?.addChild(element)
        }
    }

    private func initialisedGrids(count: Int) {
        for index in 0..<count {
            let grid = SKSpriteNode(imageNamed: "elementbox")
            let size = HUDConstants.elementQueueGridSize
            grid.size = size
            let position = CGPoint(x: HUDConstants.elementQueueStartPos.x + CGFloat(index) * size.width,
                                   y: HUDConstants.elementQueueStartPos.y)
            grid.position = position
            self.addChild(grid)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
