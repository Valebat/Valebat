//
//  BaseMapEntity.swift
//  Valebat
//
//  Created by Jing Lin Shi on 20/3/21.
//

import GameplayKit

protocol BaseMapObjectEntity: BaseMapEntity {
    var objectType: MapObjectEnum { get }
}
