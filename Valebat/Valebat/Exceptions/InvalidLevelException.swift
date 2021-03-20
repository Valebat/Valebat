//
//  WrongElementTypeException.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//
import CoreData

class InvalidLevelException: NSException {

    init() {
        super.init(
            name: NSExceptionName(rawValue: "Invalid level parameter"),
            reason: "The level of any element must be greater than 1",
            userInfo: nil)
    }

    // required by Xcode compiler. strange thing
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
