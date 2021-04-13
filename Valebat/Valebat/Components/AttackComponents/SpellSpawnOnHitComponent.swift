//
//  SpawnOnDeathComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 4/4/21.
//

import GameplayKit
class SpellSpawnOnHitComponent: SpellHitComponent {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(animatedTextures: [SKTexture], timePerFrame: Double, effectParams: [Any]) {
        super.init(animatedTextures: animatedTextures, timePerFrame: timePerFrame, effectParams: effectParams)
    }

    override func onHit() {
        guard let pos = self.entity?.component(ofType: SpriteComponent.self)?.node.position else {
            return super.onHit()
        }
        guard let entityManager = baseEntity?.entityManager else {
            return super.onHit()
        }
        guard let spawnType = self.params[0] as? BasicType,
              let spawnLevel = self.params[1] as? Double else {
            return super.onHit()
        }
        for angle in stride(from: 0, to: 2 * Double.pi, by: Double.pi / 4) {
            do {
                try entityManager.shootSpell(from: pos,
                                                           with: CGVector(dx: -sin(angle), dy: cos(angle)),
                                                           using: [Element(with: spawnType, at: spawnLevel)])
            } catch SpellErrors.invalidLevelError {
                print("Wrong level was given")
            } catch SpellErrors.wrongBasicTypeError {
                print("Wrong element type was given")
            } catch {
                print("Unexpected error")
            }
        }
        super.onHit()
    }
}
