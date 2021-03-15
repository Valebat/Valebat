//
//  RenderComponent.swift
//  Valebat
//
//  Created by Aloysius Lim on 12/3/21.
//

import Foundation
import UIKit
import GameplayKit

class RenderComponent: GKComponent {
    var node: SCNNode

    init(node: SCNNode) {
        self.node = node
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
