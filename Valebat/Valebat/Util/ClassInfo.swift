//
//  ClassInfo.swift
//  Valebat
//
//  Created by Sreyans Sipani on 29/3/21.
//

// Many thanks to Code Different: http://stackoverflow.com/a/42749141/3440266
import Foundation

struct ClassInfo: CustomStringConvertible, Equatable {
    let classObject: AnyClass
    let classNameFull: String
    let className: String

    init?(_ classObject: AnyClass?) {
        guard classObject != nil else { return nil }

        self.classObject = classObject!

        let cName = class_getName(classObject)
        self.classNameFull = String(cString: cName)
        self.className = self.classNameFull.components(separatedBy: ".").last!
    }

    var superclassInfo: ClassInfo? {
        let superclassObject: AnyClass? = class_getSuperclass(self.classObject)
        return ClassInfo(superclassObject)
    }

    var description: String {
        return self.classNameFull
    }

    static func == (lhs: ClassInfo, rhs: ClassInfo) -> Bool {
        return lhs.classNameFull == rhs.classNameFull
    }
}
