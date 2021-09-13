//
//  BaseCoreData.swift
//  WTest
//
//  Created by Anderson F Carvalho on 13/09/21.
//

import CoreData

enum CoreDataOperation {
    case success
    case failed
}

enum ErrorType: Error {
    case errorDefault
}

final class BaseCoreData {
    
    static let shared = BaseCoreData(modelName: "WTest")
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
        
        initPersistentContainer()
    }
    
    private func initPersistentContainer() {
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("Load error:", error)
            } else {
                debugPrint("stored path: ", description)
            }
        }
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        return container
    }()
        
    lazy var managedContext: NSManagedObjectContext = {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.parent = persistentContainer.viewContext
        return mainContext
    }()
    
    lazy var privateManagedContext: NSManagedObjectContext = {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = persistentContainer.viewContext
        return privateContext
    }()
    
    func saveContext(completion: @escaping (CoreDataOperation) -> ()) {
        do {
            try privateManagedContext.save()
            completion(.success)
        } catch {
            completion(.failed)
        }
    }
    
    func fetchEntities<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T]? {
        let fetchData = T.fetchRequest()
        
        do {
            fetchData.predicate = predicate
            fetchData.sortDescriptors = sortDescriptors
            return try managedContext.fetch(fetchData) as? [T]
        } catch {
            return nil
        }
    }
}
