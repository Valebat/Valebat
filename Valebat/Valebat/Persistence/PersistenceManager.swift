//
//  PersistenceManager.swift
//  Valebat
//
//  Created by Zhang Yifan on 2/4/21.
//

import Foundation

class PersistenceManager {

    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }

}
