//
//  UserDefault.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import Foundation

class UserDefault {
    static var isFirstLaunch: Bool {
        get {
            UserDefaults.standard.value(forKey: Constants.isFirstLaunchKey) as? Bool ?? true
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.isFirstLaunchKey)
        }
    }
}
