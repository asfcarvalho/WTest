//
//  String.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidText: Bool {
        let regex = "([A-Z]{4})-([A-Z]{2})"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
