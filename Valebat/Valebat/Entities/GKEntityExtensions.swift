//
//  GKEntityExtensions.swift
//  Valebat
//
//  Created by Aloysius Lim on 21/3/21.
//

import GameplayKit

extension GKEntity {

    func component<P>(conformingTo protocol: P.Type) -> P? {
        for component in components {
            if let wantedComponent = component as? P {
                return wantedComponent
            }
        }
        return nil
    }
}
