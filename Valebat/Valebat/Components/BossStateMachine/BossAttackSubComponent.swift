//
//  BossAttackSubComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/4/21.
//

import Foundation

protocol BossAttackSubComponent {
    func update(deltaTime: TimeInterval)
    var isCurrentlyCasting: Bool { get set }
    func triggerAttack()
    var attachedAttackComponent: BossAttackComponent? { get set }
    var coolDown: TimeInterval { get set }
    func deathCleanUp()
}
