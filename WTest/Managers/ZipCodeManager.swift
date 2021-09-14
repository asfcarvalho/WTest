//
//  ZipCodeManager.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import UIKit
import CodableCSV

public class ZipCodeManager {
    
    static let shared = ZipCodeManager()
    
    private var configDecoder = CSVDecoder.Configuration()
    private var dataBase: DataBaseManagerInterface?
    
    init(_ dataBase: DataBaseManagerInterface = DatabaseManager()) {
        configDecoder.headerStrategy = .firstLine
        configDecoder.nilStrategy = .empty
        configDecoder.trimStrategy = .whitespaces
        configDecoder.encoding = .utf8
        
        self.dataBase = dataBase
    }
    
    /**
     Download all zip code from https://github.com/centraldedados/codigos_postais/raw/master/data/codigos_postais.csv
     save in loca database
     */
    func downloadZipCode(complete: @escaping ([ZipCodeModel]) -> Void) {
        guard let url = URL(string: "https://github.com/centraldedados/codigos_postais/raw/master/data/codigos_postais.csv") else {
            complete([])
            return
        }
        
        var zipCodeList: [ZipCodeModel] = []
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                complete([])
                return
            }

            let decoder = try? CSVDecoder(configuration: self.configDecoder).lazy(from: data)
            decoder?.forEach( {
                if let zipCode = try? $0.decode(ZipCodeModel.self) {
                    zipCodeList.append(zipCode)
                }
            })
            
            complete(zipCodeList)
        }.resume()
    }
    
    func loadLocalZipCode() -> [ZipCodeModel] {
        guard let zipCodeList = dataBase?.getObjects(ZipCodeModel.self) as? [ZipCodeModel] else {
            return []
        }
        
        return zipCodeList
    }
    
    /// saving the zipcodes in local data base
    func saveZipCode(zipCodeList: [ZipCodeModel], complete: @escaping (Bool) -> Void) {
        
        if dataBase?.getObjects(ZipCodeModel.self) != nil {
            dataBase?.delete(ZipCodeModel.self)
        }
        
        dataBase?.create(zipCodeList, completion: complete)
    }
}
