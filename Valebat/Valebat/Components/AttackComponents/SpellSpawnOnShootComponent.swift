//
//  SpellSpawnOnShootComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 9/4/21.
//

import GameplayKit
class SpellSpawnOnShootComponent: SpellEffectComponent {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(effectParams: [Any]) {
        super.init(effectParams: effectParams)
    }

    override func createEffect() {
        guard let pos = baseEntity?.component(ofType: SpriteComponent.self)?.node.position else {
            return super.createEffect()
        }
        guard let orientation = baseEntity?.component(ofType: RegularMovementComponent.self)?.orientation else {
            return super.createEffect()
        }
        guard let entityManager = baseEntity?.entityManager else {
            return super.createEffect()
        }
        guard let spawnType = self.params[0] as? BasicType,
              let spawnLevel = self.params[1] as? Double else {
            return super.createEffect()
        }
        for angle in stride(from: 0, to: 2*Double.pi, by: Double.pi/2) {
            do {
                try entityManager.shootSpell(from: pos, with: CGVector(dx: -sin(angle), dy: cos(angle)),
                                             using: [Element(with: spawnType, at: spawnLevel)])
            } catch SpellErrors.invalidLevelError {
                print("Wrong level was given")
            } catch SpellErrors.wrongBasicTypeError {
                print("Wrong element type was given")
            } catch {
                print("Unexpected error")
            }
        }
        super.createEffect()
        baseEntity?.removeComponent(ofType: Self.self)
    }
}
