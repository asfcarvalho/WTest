//
//  ZipCodeViewModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 14/09/21.
//

import Foundation

class ZipCodeListViewModel {
    
    var zipCodeList: [ZipCodeViewModel] = []
    
    struct ZipCodeViewModel {
        let zipCode: String
        let desigPostal: String
    }
    
    func fetchData(completion: @escaping () -> Void) {
        if UserDefault.isFirstLaunch {
            ZipCodeManager.shared.downloadZipCode(complete: { zipCodeList in
                ZipCodeManager.shared.saveZipCode(zipCodeList: zipCodeList) { status in
                    UserDefault.isFirstLaunch = !status
                    self.setZipCodeFromLocalData()
                    completion()
                }
            })
        } else {
            setZipCodeFromLocalData()
            completion()
        }
    }
    
    private func setZipCodeFromLocalData() {
        let zipCodeLocalList = ZipCodeManager.shared.loadLocalZipCode()
        
        zipCodeList = zipCodeLocalList.map({
            ZipCodeViewModel(zipCode: "\($0.numCodPostal)-\($0.extCodPostal)",
                             desigPostal: $0.desigPostal)
        })
    }
    
    func filterZipCode(with text: String) {
        let zipCodeLocalList = ZipCodeManager.shared.loadLocalZipCodeFiltered(with: text)
        
        zipCodeList = zipCodeLocalList.map({
            ZipCodeViewModel(zipCode: "\($0.numCodPostal)-\($0.extCodPostal)",
                             desigPostal: $0.desigPostal)
        })
    }
}
