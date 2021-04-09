//
//  BaseEntity.swift
//  Valebat
//
//  Created by Aloysius Lim on 6/4/21.
//

import Foundation
import GameplayKit

class BaseEntity: GKEntity {
    weak var entityManager: EntityManager?

    func addComponent(_ component: BaseComponent) {
        addComponent(component as GKComponent)
        component.baseEntity = self
    }
}
