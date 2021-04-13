//
//  AimIndicatorComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 9/4/21.
//

import GameplayKit

class AimIndicatorComponent: SpriteComponent {

    let playerSize: CGFloat

    init(size: CGSize, playerSize: CGFloat) {
        self.playerSize = playerSize
        let texture  = CustomTexture.initialise(imageNamed: "aim_indicator")
        super.init(texture: texture, size: size, position: CGPoint(x: 0, y: 0))
        self.node.isHidden = true
    }

    override func didAddToEntity() {
        entity?.component(ofType: SpriteComponent.self)?.node.addChild(self.node)
        super.didAddToEntity()
    }

    override func willRemoveFromEntity() {
        super.willRemoveFromEntity()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onJoystickEnded() {
        self.node.isHidden = true
    }

    func onJoystickMoved(angle: CGFloat, playerAngle: CGFloat?) {
        self.node.isHidden = false
        let shootAngle = angle - (playerAngle ?? 0)
        self.node.zRotation = shootAngle
        self.node.position = CGPoint(x: self.playerSize / 2 * cos(shootAngle + CGFloat(Double.pi/2)),
                                     y: self.playerSize / 2 * sin(shootAngle + CGFloat(Double.pi/2)))

    }
}
