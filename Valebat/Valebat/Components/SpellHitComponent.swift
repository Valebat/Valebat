//
//  SpellDeathComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani
//

import GameplayKit
class SpellHitComponent: GKComponent {
    let animation: SKAction
    let params: [Any]

    required init(animatedTextures: [SKTexture], timePerFrame: Double, effectParams: [Any]) {
        self.params = effectParams
        self.animation = SKAction.animate(with: animatedTextures, timePerFrame: timePerFrame)
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onHit() {
        if let entity = self.entity {
            entity.component(ofType: RegularMovementComponent.self)?.stop() // Removing component doesn't work ?
            entity.removeComponent(ofType: PhysicsComponent.self)
            entity.component(ofType: SpriteComponent.self)?.node.run(self.animation, completion: {
                EntityManager.getInstance().remove(entity)
            })
        }
    }
}
