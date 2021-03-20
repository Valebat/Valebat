//
//  PhysicsComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit
import SpriteKit

protocol ContactBeginObserver {
    func contactDidBegin(with entity: GKEntity)
}

protocol ContactEndObserver {
    func contactDidEnd(with entity: GKEntity)
}

protocol ContactAllObserver: ContactBeginObserver, ContactEndObserver {

}

class PhysicsComponent: GKComponent {
    let physicsBody: SKPhysicsBody
    var contactBeginObservers = [ObjectIdentifier: ContactBeginObserver]()
    var contactEndObservers = [ObjectIdentifier: ContactEndObserver]()
    init(physicsBody: SKPhysicsBody, collisionType: CollisionType) {
        self.physicsBody = physicsBody
        physicsBody.categoryBitMask = collisionType.rawValue
        physicsBody.collisionBitMask = 0
        physicsBody.affectedByGravity = false
        self.physicsBody.contactTestBitMask = CollisionType.generateContactMask(type: collisionType)
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

    func triggerContactBegin(with entity: GKEntity) {
        contactBeginObservers.values.forEach({ $0.contactDidBegin(with: entity) })
    }
    func triggerContactEnd(with entity: GKEntity) {
        contactEndObservers.values.forEach({ $0.contactDidEnd(with: entity) })
    }

}
