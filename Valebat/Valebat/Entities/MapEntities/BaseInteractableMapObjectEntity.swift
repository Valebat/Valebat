//
//  BaseInteractableMapObjectEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/5/21.
//

import GameplayKit

class BaseInteractableMapObjectEntity: BaseInteractableEntity, BaseMapObjectEntity {
    var objectType: MapObjectEnum

    init(size: CGSize, position: CGPoint, type: MapObjectEnum, texture: CustomTexture) {
        self.objectType = type
        super.init(texture: texture, size: size, physicsType: .wall, position: position)
    }

    convenience init(size: CGSize, position: CGPoint, type: MapObjectEnum) {
        self.init(size: size, position: position, type: type,
                  texture: CustomTexture.initialise(imageNamed: type.rawValue))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
