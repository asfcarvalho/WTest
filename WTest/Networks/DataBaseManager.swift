//
//  DataBaseManager.swift
//  WTest
//
//  Created by Anderson F Carvalho on 14/09/21.
//

import Foundation
import RealmSwift

protocol DataBaseManagerInterface {
    var realm: Realm { get }
    
    func create(_ objects: [Object], completion: ((Bool) -> Void)?)
    func update(_ object: [Object], completion: (() -> Void)?)
    func get(_ objectType: Object.Type, primaryKey: String) -> Object?
    func getObjects(_ objectType: Object.Type) -> [Object]
    func delete(_ objectType: Object.Type, primaryKey: String)
    func delete(_ objectType: Object.Type)
    func deleteObjects(_ objects: [Object])
}

class DatabaseManager: DataBaseManagerInterface {
        
    lazy public var realm: Realm = try! realmInstance()
    
    func realmInstance() throws -> Realm {
        /// configuration with migration database and shrink database if its reach more than 10MB
        let config = Realm.Configuration(
            schemaVersion: 1,
            shouldCompactOnLaunch: { totalBytes, usedBytes in
                let oneHundredMB = 10 * 1024 * 1024
                return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
            }
        )
        
        if let relamURL = Realm.Configuration.defaultConfiguration.fileURL {
            debugPrint("File: \(#file). Method: \(#function), \(relamURL)")
        }
    
        do {
            return try Realm(configuration: config)
        } catch let error as NSError {
            debugPrint("Error starting realm: \(error.localizedDescription)")
            return try Realm()
        }
    }
    
    /**
        Create data to database
     
        - Parameters:
            - objects: Realm Object Array
            - completion: callbak after action done
     */
    func create(_ objects: [Object], completion: ((Bool) -> Void)?) {
        
        do {
            try realm.write {
                realm.add(objects)
                
                completion?(true)
            }
        } catch {
            completion?(false)
        }
    }
    
    /**
        Update objects on database
     
        - Parameters:
            - objects: Realm Object Array
            - completion: callbak after action done
     */
    func update(_ object: [Object], completion: (() -> Void)?) {
        try! realm.write {
            realm.add(object, update: .all)
        }
        
        completion?()
    }
    
    /**
        Select specific object
     
        - Parameters:
            - objectType: Realm Object to get from DB
            - primaryKey: Primary Key to find
      
        - Returns: Realm Object
     */
    func get(_ objectType: Object.Type, primaryKey: String) -> Object? {
        realm.object(ofType: objectType, forPrimaryKey: primaryKey)
    }
    
    /**
        Select data from database
     
        - Parameters:
            - objectType: Realm Object to get from DB
      
        - Returns: Realm Object Array
     */
    func getObjects(_ objectType: Object.Type) -> [Object] {
        realm.objects(objectType).map({ $0 })
    }
    
    /**
        Delete specific object type
     
        - Parameters:
            - objectType: Realm Object
     */
    func delete(_ objectType: Object.Type, primaryKey: String) {
        guard let object = self.get(objectType, primaryKey: primaryKey) else {
            return
        }
        
        self.deleteObjects([object])
    }
    
    /**
        Delete all object type
     
        - Parameters:
            - objectType: Realm Object
     */
    func delete(_ objectType: Object.Type) {
        self.deleteObjects(self.getObjects(objectType))
    }
    
    /**
        Delete specif object in database
     
        - Parameters:
            - objects: Realm Object Array
     */
    func deleteObjects(_ objects: [Object]) {
        try! realm.write {
            realm.delete(objects)
        }
    }
}
