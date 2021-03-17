//
//  ElementButton.swift
//  Valebat
//
//  Created by Zhang Yifan on 17/3/21.
//

import SpriteKit

class ElementButton: SKSpriteNode {

    var elementType: ElementType
    weak var elementSelection: ElementSelection?

    init(elementType: ElementType) {
        self.elementType = elementType
        let texture = SKTexture(imageNamed: elementType.imageName)
        super.init(texture: texture, color: UIColor.clear, size: HUDConstants.elementQueueElementSize)
        self.isUserInteractionEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        elementSelection?.setNewElement(elementType: elementType)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
