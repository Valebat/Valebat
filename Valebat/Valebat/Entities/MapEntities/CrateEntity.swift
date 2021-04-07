//
//  CrateEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/3/21.
//

import GameplayKit

class CrateEntity: BaseInteractableEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .crate

    init(size: CGSize, position: CGPoint) {
        super.init(texture: SKTexture(imageNamed: "crate"), size: size, physicsType: .wall, position: position)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
