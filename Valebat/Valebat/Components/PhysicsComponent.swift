//
//  PhysicsComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation

import GameplayKit
import SpriteKit
class PhysicsComponent: GKComponent {
    let physicsBody: SKPhysicsBody
    
    init(physicsBody: SKPhysicsBody) {
        self.physicsBody = physicsBody
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        guard let node = self.entity?.component(ofType: SpriteComponent.self)?.node else {
            return
        }
        node.physicsBody = physicsBody
    }
    
    override func willRemoveFromEntity() {
        guard let node = self.entity?.component(ofType: SpriteComponent.self)?.node else {
            return
        }
        node.physicsBody = nil
    }
}
