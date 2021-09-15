//
//  Identifier.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

protocol Identifier {}

extension Identifier where Self: NSObject {

    static var identifier: String {
        String(describing: self)
    }
}

extension NSObject: Identifier {}
