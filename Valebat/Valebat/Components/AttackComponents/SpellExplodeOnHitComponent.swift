//
//  SpellExplodeOnHitComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 9/4/21.
//

import GameplayKit

class SpellExplodeOnHitComponent: SpellEffectComponent {
    let animation: SKAction

    required init(effectParams: [Any]) {
        self.animation = SKAction.animate(with: effectParams[0] as? [SKTexture] ?? [],
                                          timePerFrame: effectParams[1] as? Double ?? 0.05)
        super.init(effectParams: effectParams)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func createEffect() {
        if let entity = self.baseEntity {
            entity.component(ofType: RegularMovementComponent.self)?.stop() // Removing component doesn't work ?
            entity.removeComponent(ofType: PhysicsComponent.self)
            entity.component(ofType: SpriteComponent.self)?.node.run(self.animation, completion: {
                entity.entityManager?.remove(entity)
            })
        }
    }
}
