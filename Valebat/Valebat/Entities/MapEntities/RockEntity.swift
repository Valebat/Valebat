//
//  RockEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 14/3/21.
//

import GameplayKit

class RockEntity: BaseInteractableEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .rock

    init(size: CGSize, position: CGPoint) {
        super.init(texture: SKTexture(imageNamed: "rock"), size: size, physicsType: .wall, position: position)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
