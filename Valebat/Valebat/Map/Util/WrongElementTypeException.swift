//
//  WrongElementTypeException.swift
//  Valebat
//
//  Created by Sreyans Sipani on 13/3/21.
//

import CoreData

class WrongElementTypeException: NSException {

    init() {
        super.init(
            name: NSExceptionName(rawValue: "Wrong Element Type"),
            reason: "The element should have the correct type for the spell",
            userInfo: nil)
    }
    
    //required by Xcode compiler. strange thing
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

