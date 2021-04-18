//
//  GenericMapEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 18/4/21.
//

import GameplayKit

class GenericMapEntity: BaseInteractableEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum

    init(size: CGSize, position: CGPoint, type: MapObjectEnum) {
        self.objectType = type
        super.init(texture: CustomTexture.initialise(imageNamed: objectType.rawValue),
                   size: size, physicsType: .wall, position: position)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
