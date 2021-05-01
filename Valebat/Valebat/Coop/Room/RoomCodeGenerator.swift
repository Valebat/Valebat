//
//  RoomCodeGenerator.swift
//  Valebat
//
//  Created by Jing Lin Shi on 16/4/21.
//

class RoomCodeGenerator {
    /// Function taken from
    /// https://stackoverflow.com/questions/26845307/generate-random-alphanumeric-string-in-swift/33860834.
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijkmnopqrstuvwxyz0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
