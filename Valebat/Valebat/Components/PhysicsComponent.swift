//
//  PhysicsComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit
import SpriteKit

protocol ContactObserver {
    func contact(with entity: GKEntity)
}

class PhysicsComponent: GKComponent {
    let physicsBody: SKPhysicsBody
    var contactObservers = [ObjectIdentifier: ContactObserver]()
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
        contactObservers.values.forEach({ $0.contact(with: entity) })
    }

    override func update(deltaTime seconds: TimeInterval) {
        // print(seconds)
       // print("Sdfsdf")
        let contactEntities = physicsBody.allContactedBodies()
            .filter({ self.physicsBody.categoryBitMask & $0.contactTestBitMask != 0 })
            .compactMap({ $0.node?.entity })
        contactEntities.forEach({ triggerContactBegin(with: $0) })
    }

}
