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
        guard let playerNode = baseEntity?.component(ofType: SpriteComponent.self)?.node else {
            return super.createEffect()
        }
        let pos = playerNode.position
        guard let shootAngle = baseEntity?.component(ofType: RegularMovementComponent.self)?.orientation else {
            return super.createEffect()
        }
        guard let entityManager = baseEntity?.entityManager else {
            return super.createEffect()
        }
        guard let spawnType = self.params[0] as? BasicType,
              let spawnLevel = self.params[1] as? Double else {
            return super.createEffect()
        }
        let dmgMul = (baseEntity as? PlayerSpellEntity)?
            .component(conformingTo: DamageComponent.self)?.damageValues.values.max() ?? 1.0
        for angle in stride(from: Double(shootAngle) - .pi, to: Double(shootAngle) + .pi/4, by: Double.pi/4) {
            do {
                try entityManager.shootSpell(from: pos, with: CGVector(dx: -sin(angle), dy: cos(angle)),
                                             using: [Element(with: spawnType, at: spawnLevel)],
                                             damageMultiplier: dmgMul)
            } catch SpellErrors.invalidLevelError {
                print("Wrong level was given.")
            } catch SpellErrors.wrongBasicTypeError {
                print("Wrong element type was given.")
            } catch {
                print("Unexpected error.")
            }
        }
        super.createEffect()
        baseEntity?.removeComponent(ofType: Self.self)
    }
}
