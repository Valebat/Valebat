//
//  WallEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 14/3/21.
//

import GameplayKit

class WallEntity: BaseInteractableEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .wall

    init(size: CGSize, position: CGPoint) {
        super.init(texture: CustomTexture.initialise(imageNamed: "wall"),
                   size: size, physicsType: .wall, position: position)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
