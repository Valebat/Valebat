//
//  SpellDeathComponent.swift
//  Valebat
//
//  Created by Sreyans Sipani
//

import GameplayKit
class SpellEffectComponent: BaseComponent {
    let params: [Any]

    required init(effectParams: [Any]) {
        self.params = effectParams
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func createEffect() {}
}
