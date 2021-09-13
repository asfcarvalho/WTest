//
//  ZipCodeManager.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import UIKit
import CodableCSV

struct ZipCodeModel: Codable {
    let codLocalidade: String
    let numCodPostal: String
    let extCodPostal: String
    
    enum CodingKeys: String, CodingKey {
        case codLocalidade = "cod_localidade"
        case numCodPostal = "num_cod_postal"
        case extCodPostal = "ext_cod_postal"
    }
}

class ZipCodeManager {
    
    static let shared = ZipCodeManager()
    
    private var configDecoder = CSVDecoder.Configuration()
    private var coreData = BaseCoreData.shared
    
    init() {
        configDecoder.headerStrategy = .firstLine
        configDecoder.nilStrategy = .empty
        configDecoder.trimStrategy = .whitespaces
        configDecoder.encoding = .utf8
    }
    
    /**
     Download all zip code from https://github.com/centraldedados/codigos_postais/raw/master/data/codigos_postais.csv
     save in loca database
     */
    func downloadZipCode(complete: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://github.com/centraldedados/codigos_postais/raw/master/data/codigos_postais.csv") else {
            return
        }
        
        var zipCodeList: [ZipCodeModel] = []
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }

            let decoder = try? CSVDecoder(configuration: self.configDecoder).lazy(from: data)
            decoder?.forEach( {
                if let zipCode = try? $0.decode(ZipCodeModel.self) {
                    zipCodeList.append(zipCode)
                }
            })
            
            self.saveZipCode(zipCodeList: zipCodeList, complete: complete)
        }.resume()
    }
    
    func loadLocalZipCode() -> [ZipCodeModel] {
        let result = coreData.fetchEntities(entity: ZipCode.self)
        
        let zipCodeList: [ZipCodeModel] = result?.map({ item in
            ZipCodeModel(codLocalidade: item.codLocalidade ?? "",
                         numCodPostal: item.numCodPostal ?? "",
                         extCodPostal: item.extCodPostal ?? "")
        }) ?? []
        
        return zipCodeList
    }
    
    /// saving the zipcodes in local data base
    private func saveZipCode(zipCodeList: [ZipCodeModel], complete: @escaping (Bool) -> Void) {
        
//        let group = DispatchGroup()
//        var success = true
//
//        zipCodeList.forEach( {
//            group.enter()
            let zipCode = ZipCode(context: coreData.managedContext)
        zipCode.codLocalidade = zipCodeList.first?.codLocalidade
        zipCode.extCodPostal = zipCodeList.first?.extCodPostal
        zipCode.numCodPostal = zipCodeList.first?.codLocalidade
            
            coreData.saveContext { result in
                switch result {
                case .success:
                    complete(true)
                case .failed:
//                    success = false
                complete(false)
                }
//                group.leave()
            }
//        })
//
//        group.notify(queue: .main) {
//            complete(success)
//        }
    }
}
