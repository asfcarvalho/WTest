//
//  ViewController.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if UserDefault.isFirstLaunch {
            Loading.shared.showLoading(view)
            ZipCodeManager.shared.downloadZipCode(complete: { zipCodeList in
                ZipCodeManager.shared.saveZipCode(zipCodeList: zipCodeList) { status in
                    UserDefault.isFirstLaunch = !status
                    Loading.shared.stopLoading()
                }                
            })
        } else {
            let _ = ZipCodeManager.shared.loadLocalZipCode()
        }
    }
}

