//
//  String+dateFormat.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import Foundation

enum DateFormat: String {
    case long = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case short = "dd MMMM yyyy"
    case longString = "EEEE, dd MMMM yyyy"
}

extension String {
    
    func toLogDate() -> Date? {
        let formatDate = DateFormatter()
        formatDate.dateFormat = DateFormat.long.rawValue
        
        return formatDate.date(from: self)
    }
}
