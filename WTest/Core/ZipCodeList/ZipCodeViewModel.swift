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
                    self.setZipCodeFromLocalData(completed: completion)
                }
            })
        } else {
            setZipCodeFromLocalData(completed: completion)
        }
    }
    
    private func setZipCodeFromLocalData(completed: @escaping ()-> Void) {
        ZipCodeManager.shared.loadLocalZipCode(completed: { response in
            self.zipCodeList = response.map({
                ZipCodeViewModel(zipCode: "\($0.numCodPostal)-\($0.extCodPostal)",
                                 desigPostal: $0.desigPostal)
            })
            completed()
        })
    }
    
    func filterZipCode(with text: String) {
        ZipCodeManager.shared.loadLocalZipCodeFiltered(with: text, completed: { response in
            self.zipCodeList = response.map({
                ZipCodeViewModel(zipCode: "\($0.numCodPostal)-\($0.extCodPostal)",
                                 desigPostal: $0.desigPostal)
            })
        })
    }
    
    func getZipCodeDescription(from index: Int) -> String {
        let zipCode = zipCodeList[index]
        
        return "\(zipCode.zipCode) \(zipCode.desigPostal)"
    }
}
