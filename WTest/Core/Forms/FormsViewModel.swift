//
//  FormsViewModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import Foundation

struct FormsViewModel {
    var description: String = ""
    var email: String = ""
    var idText: String = ""
    var text: String = ""
    var date: String = ""
    var status: String = ""
    var zipCode: String = ""
    
    func isValidFields() -> Bool {
        !description.isEmpty &&
        email.isValidEmail &&
        idText.isJustNumber &&
        text.isValidText &&
        !date.isEmpty &&
        !status.isEmpty &&
        !zipCode.isEmpty
    }
    
    func isMonday(date: Date) -> Bool {
        DateManager.numberOfWeeksInMonth(date) == 2
    }
}
