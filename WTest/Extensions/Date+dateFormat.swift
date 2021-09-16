//
//  Date+dateFormat.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

extension Date {
    func toShortDateString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = DateFormat.short.rawValue
        
        return dateFormat.string(from: self)
    }
    
    func toLongDateString() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = DateFormat.longString.rawValue
        
        return dateFormat.string(from: self)
    }
}
