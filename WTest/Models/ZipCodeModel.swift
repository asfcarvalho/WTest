//
//  ZipCodeModel.swift
//  WTest
//
//  Created by Anderson F Carvalho on 14/09/21.
//

import Foundation
import RealmSwift

class ZipCodeModel: Object, Codable {
    @Persisted var zipCodeId: String = UUID().uuidString
    @Persisted var numCodPostal: String
    @Persisted var extCodPostal: String
    
    enum CodingKeys: String, CodingKey {
        case numCodPostal = "num_cod_postal"
        case extCodPostal = "ext_cod_postal"
    }
    
    override static func primaryKey() -> String? {
        "zipCodeId"
    }
}
