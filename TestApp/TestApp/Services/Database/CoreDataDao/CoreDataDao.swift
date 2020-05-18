//
//  CoreDataDao.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import CoreData

class CoreDataDao {
    private struct Constants {
        static let coreDataName = "TestApp"
        static let recordObjectName = "RecordObject"
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreDataName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - DatabaseInterface methods implementation
extension CoreDataDao: DatabaseInterface {
    func save(record: Record, completion: (Error?) -> Void) {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.recordObjectName, in: context) else { return }
        let object = RecordEntity(entity: entity, insertInto: context)
        fill(managedObject: object, with: record)
        saveContext()
    }
    
    func update(record: Record, completion: (Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.recordObjectName)
        fetchRequest.predicate = NSPredicate(format: "name = %@", record.name)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let object = result.first as? RecordEntity else { return }
            fill(managedObject: object, with: record)
            saveContext()
        } catch {
            completion(error)
        }
    }
    
    func delete(record: Record, completion: (Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.recordObjectName)
        fetchRequest.predicate = NSPredicate(format: "name = %@", record.name)
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let object = result.first as? RecordEntity else { return }
            context.delete(object)
            saveContext()
        } catch {
            completion(error)
        }
    }
    
    func loadItems(completion: (([Record], Error?) -> Void)) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.recordObjectName)
        
        do {
            let result = try context.fetch(fetchRequest)
            let recordObjects = result as? [RecordEntity] ?? []
            
            var records: [Record] = []
            
            for recordObject in recordObjects {
                records.append(Record.from(managedObject: recordObject))
            }
            
            completion(records, nil)
        } catch {
            completion([], error)
        }
    }
}

// MARK: - Private extension for filling Core Data RecordEntity with Record model
private extension CoreDataDao {
    @discardableResult
    func fill(managedObject: RecordEntity, with object: Record) -> RecordEntity {
        managedObject.name = object.name
        return managedObject
    }
}

// MARK: - Private extension to init Record object from RecordEntity managed object
fileprivate extension Record {
    static func from(managedObject: RecordEntity) -> Record {
        return Record(name: managedObject.name ?? "")
    }
}


