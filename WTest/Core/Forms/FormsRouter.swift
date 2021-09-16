//
//  FormsRouter.swift
//  WTest
//
//  Created by Anderson F Carvalho on 16/09/21.
//

import UIKit

class FormsRouter {
    func openZipCodeView(from viewControler: UIViewController,
                         handleZipCodeSelected: ((String) -> Void)?) {
        let zipCode = ZipCodeViewController()
        zipCode.handleZipCodeSelected = handleZipCodeSelected
        viewControler.navigationController?.pushViewController(zipCode, animated: true)
    }
}
