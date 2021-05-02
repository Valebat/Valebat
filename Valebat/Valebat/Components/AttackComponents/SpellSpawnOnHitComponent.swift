//
//  SpawnOnDeathComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani on 4/4/21.
//

import GameplayKit
class SpellSpawnOnHitComponent: SpellExplodeOnHitComponent {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(effectParams: [Any]) {
        super.init(effectParams: effectParams)
    }

    override func createEffect() {
        guard let pos = self.entity?.component(conformingTo: MoveComponent.self)?.currentPosition else {
            return super.createEffect()
        }
        guard let entityManager = baseEntity?.entityManager else {
            return super.createEffect()
        }
        guard let spawnType = self.params[2] as? BasicType,
              let spawnLevel = self.params[3] as? Double else {
            return super.createEffect()
        }
        let dmg = (baseEntity as? PlayerSpellEntity)?
            .component(conformingTo: DamageComponent.self)?.damageValues.values.max() ?? 1.0
        let offsetRadius: CGFloat = 15.0

        for angle in stride(from: 0, to: 2 * Double.pi, by: Double.pi / 4) {
            do {
                let unitVector = CGVector(dx: -sin(angle), dy: cos(angle))
                try entityManager.shootSpell(from: pos + (unitVector * offsetRadius).convertToPoint(),
                                             with: unitVector,
                                             using: [Element(with: spawnType, at: spawnLevel)],
                                             damageMultiplier: (dmg / DamageConstants.damageValue))
            } catch SpellErrors.invalidLevelError {
                print("Wrong level was given.")
            } catch SpellErrors.wrongBasicTypeError {
                print("Wrong element type was given.")
            } catch {
                print("Unexpected error.")
            }
        }
        super.createEffect()
    }
}
