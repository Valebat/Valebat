//
//  BaseIndicatorComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 18/4/21.
//

import SpriteKit

class AimIndicatorComponent: SpriteComponent {
    static let textureImage: String = "aim_indicator" // Default value

    init(size: CGSize) {
        let texture  = CustomTexture.initialise(imageNamed: AimIndicatorComponent.textureImage)
        super.init(texture: texture, size: size, position: CGPoint(x: 0, y: 0))
        self.node.isHidden = true
    }

    override func didAddToEntity() {
        entity?.component(ofType: SpriteComponent.self)?.node.addChild(self.node)
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        node.removeFromParent()
        super.willRemoveFromEntity()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onJoystickEnded() -> Bool {
        let lastState = node.isHidden
        node.isHidden = true
        return !lastState
    }

    func onJoystickMoved(shootAngle: CGFloat, playerAngle: CGFloat?, playerPosition: CGPoint) {
        self.node.isHidden = false
        let angle = shootAngle - (playerAngle ?? 0)
        self.node.zRotation = angle
        self.node.position = CGPoint(x: ViewConstants.playerHeight / 2 * cos(shootAngle + CGFloat(Double.pi/2)),
                                     y: ViewConstants.playerHeight / 2 * sin(shootAngle + CGFloat(Double.pi/2)))
    }
}
