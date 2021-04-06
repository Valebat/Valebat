//
//  StairsEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 30/3/21.
//

import GameplayKit

class StairsEntity: BaseEntity, BaseMapObjectEntity {
    let objectType: MapObjectEnum = .stairs

    init(size: CGSize, timer: Double, position: CGPoint) {
        super.init()

        let texture = SKTexture(imageNamed: "stairs_closed")
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: position)
        addComponent(spriteComponent)

        let timerComponent = TimerComponent(timer: timer, component: AdvanceLevelComponent(at: position), parent: self,
                                            sprite: SpriteComponent(texture: SKTexture(imageNamed: "stairs_open"),
                                                                    size: size, position: position))
        addComponent(timerComponent)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
