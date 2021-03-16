//
//  ContactNotifiableProtocol.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/3/21.
//

import Foundation
import GameplayKit

protocol ContactBeginNotifiable {
    func contactDidBegin(with entity: GKEntity)
}

protocol ContactEndNotifiable {
    func contactDidEnd(with entity: GKEntity)
}

protocol ContactAllNotifiable: ContactBeginNotifiable, ContactEndNotifiable {

}
