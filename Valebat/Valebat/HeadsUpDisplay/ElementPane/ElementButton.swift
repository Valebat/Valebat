//
//  ElementButton.swift
//  Valebat
//
//  Created by Zhang Yifan on 17/3/21.
//

import SpriteKit

class ElementButton: SKSpriteNode {

    weak var elementSelection: ElementSelection?

    init(elementType: ElementType) {
        let texture = SKTexture(imageNamed: elementType.imageName)
        super.init(texture: texture, color: UIColor.clear, size: HUDConstants.elementQueueElementSize)
    }

//    private convenience init(imageNamed: String) {
//
//
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
