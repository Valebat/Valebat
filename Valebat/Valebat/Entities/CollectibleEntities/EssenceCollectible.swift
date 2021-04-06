//
//  EssenceCollectible.swift
//  Valebat
//
//  Created by Aloysius Lim on 19/3/21.
//

import GameplayKit

class EssenceCollectible: BaseEntity, CollectibleEntity {

    var type: BasicType
    var amount: Int

    static let typeToStringMapping: [BasicType: String] =
        [.fire: "fireessence", .water: "wateressence", .earth: "earthessence"]

    func onCollect(player: PlayerEntity) {
        PlayerStatsManager.addEssence(type: type, amount: amount)
    }

    init(type: BasicType, amount: Int, location: CGPoint) {
        self.type = type
        self.amount = amount
        super.init()
        let imageString = EssenceCollectible.typeToStringMapping[type] ?? ""
        let texture = SKTexture(imageNamed: imageString)
        let size = CGSize(width: ViewConstants.essenceSize, height: ViewConstants.essenceSize)
        let spriteComponent = SpriteComponent(texture: texture, size: size, position: location)
        addComponent(spriteComponent)
        addComponent(PhysicsComponent(physicsBody: SKPhysicsBody(texture: texture, size: size),
                                      collisionType: .collectible))

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
