//
//  AlertCustom.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import UIKit

class AlertCustom {
    
    static func showAlert(from viewController: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
