//
//  PhysicsComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import GameplayKit
import SpriteKit

protocol ContactObserver {
    func contact(with entity: GKEntity, seconds: TimeInterval)
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

    override func update(deltaTime seconds: TimeInterval) {
        let contactEntities = physicsBody.allContactedBodies()
            .filter({ self.physicsBody.categoryBitMask & $0.contactTestBitMask != 0 })
            .compactMap({ $0.node?.entity })
        var filteredEntities = [GKEntity]()
        var addedIdentifiers = Set<ObjectIdentifier>()
        contactEntities.forEach({ entity in
            if !addedIdentifiers.contains(ObjectIdentifier(entity)) {
                addedIdentifiers.insert(ObjectIdentifier(entity))
                filteredEntities.append(entity)
            }
        })
        if filteredEntities.count != 0 {
            contactObservers.values.forEach({ observer in
                filteredEntities.forEach({ observer.contact(with: $0, seconds: seconds) })
            })
        }
        // contactEntities.forEach({ triggerContact(with: $0) })
    }

}
