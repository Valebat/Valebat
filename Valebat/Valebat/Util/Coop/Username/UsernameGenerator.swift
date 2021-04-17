//
//  UsernameGenerator.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

class UsernameGenerator {
    /// Function adapted from
    /// https://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift/33860834.
    static func randomUsername(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return "p_" + String((0..<length).map { _ in letters.randomElement()! })
    }
}
