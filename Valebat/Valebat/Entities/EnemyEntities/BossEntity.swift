//
//  BossEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 7/4/21.
//

import GameplayKit

class BossEntity: BaseEnemyEntity, BaseMapEntity {

    init() {
        let position: CGPoint = CGPoint(x: ViewConstants.sceneWidth * ViewConstants.bossSpawnOffset,
                                        y: ViewConstants.sceneHeight * ViewConstants.bossSpawnOffset)
        let startingHP: CGFloat = 200
        let image = "boss"
        let length = ViewConstants.enemyToGridRatio * ViewConstants.gridSize * 3
        let size = CGSize(width: length, height: length)
        super.init(position: position, image: image, size: size, startingHP: startingHP)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
