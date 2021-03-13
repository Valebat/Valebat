//
//  Health.swift
//  Valebat
//
//  Created by Aloysius Lim on 12/3/21.
//

import Foundation
import UIKit
import GameplayKit

class Health: GKComponent {
    private var currentHP: Double
    var maxHP: Double
    init(startingHP: Double) {
        maxHP = startingHP
        currentHP = maxHP
        super.init()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
