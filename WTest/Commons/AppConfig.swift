//
//  AppConfig.swift
//  WTest
//
//  Created by Anderson F Carvalho on 15/09/21.
//

import UIKit

/**
 App Config
 
 A singleton responsible to get informations from plist or create some information to configure the application
 */
class AppConfig {
    /// Singleton constructor
    static let shared = AppConfig()
    private var appPlist: NSDictionary?
    
    /** Initialized
        
        All information will be declared on object WTest into project plist
     */
    init() {
        guard let plist = Bundle.main.object(forInfoDictionaryKey: "WTest") as? NSDictionary else {
            return
        }
        
        appPlist = plist
    }
    
    /**
        BaseUrl
     
        This is a base URL which is separeted in develop and release param
     */
    var baseURL: String {
        guard let urlString = appPlist?.value(forKeyPath: "baseUrl") as? String else {
            return ""
        }
        
        return urlString
    }
}
