//
//  BaseInteractableMapObjectEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 2/5/21.
//

import GameplayKit

class BaseInteractableMapObjectEntity: BaseInteractableEntity, BaseMapObjectEntity {
    var objectType: MapObjectEnum

    init(size: CGSize, position: CGPoint, type: MapObjectEnum, texture: CustomTexture, isWall: Bool = true) {
        self.objectType = type
        super.init(texture: texture, size: size, physicsType: isWall ? .wall : .none, position: position)
    }

    convenience init(size: CGSize, position: CGPoint, type: MapObjectEnum, isWall: Bool = true) {
        self.init(size: size, position: position, type: type,
                  texture: CustomTexture.initialise(imageNamed: type.rawValue),
                  isWall: isWall)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
