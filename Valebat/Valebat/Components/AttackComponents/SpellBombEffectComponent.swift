//
//  SpellBombEffect.swift
//  Valebat
//
//  Created by Sreyans Sipani on 2/5/21.
//

import GameplayKit
class SpellBombEffectComponent: SpellEffectComponent {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(effectParams: [Any]) {
        super.init(effectParams: effectParams)
    }

    override func createEffect() {
        baseEntity?.component(ofType: RegularMovementComponent.self)?.stop() // Removing component doesn't work ?
        baseEntity?.removeComponent(ofType: PhysicsComponent.self)
        guard let explosionPosition = self.entity?.component(conformingTo: MoveComponent.self)?
                .currentPosition else {
            return super.createEffect()
        }
        guard let entityManager = baseEntity?.entityManager else {
            return super.createEffect()
        }
        let scale: Int = (self.params[0] as? Int) ?? 1
        let dmg = (baseEntity as? PlayerSpellEntity)?
            .component(conformingTo: DamageComponent.self)?.damageValues.values.max() ?? 1.0
        let explosion = ExplosionEntity(position: explosionPosition, scale: scale, damageMultiplier: (dmg / DamageConstants.damageValue))
        entityManager.add(explosion)
        if let entity = self.baseEntity {
            entityManager.remove(entity)
        }
        super.createEffect()
    }
}
