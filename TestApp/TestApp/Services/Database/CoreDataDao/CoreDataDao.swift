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
        static let recordObjectName = "RecordEntity"
    }
    
    private var observers: [DaoDataObserver] = []
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.coreDataName)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
        return container
    }()
    
    init() {
        subsribeToDataChanges()
    }
    
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
    
    deinit {
        observers.removeAll()
        unsubscribeFromDataChanges()
    }
}

// MARK: - AddDaoType methods implementation
extension CoreDataDao: AddDaoType {
    func save(record: Record, completion: (Error?) -> Void) {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.recordObjectName, in: context) else { return }
        let object = RecordEntity(entity: entity, insertInto: context)
        fill(managedObject: object, with: record)
        saveContext()
    }
}

// MARK: - UpdateDaoType methods implementation
extension CoreDataDao: UpdateDaoType {
    func update(name: String, with record: Record, completion: (Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest(with: NSPredicate(format: "name = %@", record.name))
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let object = result.first as? RecordEntity else { return }
            fill(managedObject: object, with: record)
            saveContext()
        } catch {
            completion(error)
        }
    }
}

// MARK: - DeleteDaoType methods implementation
extension CoreDataDao: DeleteDaoType {
    func delete(record: Record, completion: (Error?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest(with: NSPredicate(format: "name = %@", record.name))
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let object = result.first as? RecordEntity else { return }
            context.delete(object)
            saveContext()
        } catch {
            completion(error)
        }
    }
}

// MARK: - LoadDaoType methods implementation
extension CoreDataDao: LoadDaoType {
    func loadItems(completion: (([Record], Error?) -> Void)) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest()
        
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

private extension CoreDataDao {
    func fetchRequest(with predicate: NSPredicate? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.recordObjectName)
        fetchRequest.predicate = predicate
        return fetchRequest
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

// MARK: - Data Observing methods implementation
extension CoreDataDao: DaoDataObserving {
    func addDataObserver(_ observer: DaoDataObserver) {
        if !observers.contains(where: { observer === $0 }) {
            observers.append(observer)
        }
    }
    
    func removeDataObserver(_ observer: DaoDataObserver) {
        guard let index = observers.firstIndex(where: { $0 === observer }) else { return }
        observers.remove(at: index)
    }
}

// MARK: - Data changing notifications handling
private extension CoreDataDao {
    func subsribeToDataChanges() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataChanged),
                                               name: Notification.Name.NSManagedObjectContextObjectsDidChange,
                                               object: nil)
    }
    
    func unsubscribeFromDataChanges() {
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.NSManagedObjectContextObjectsDidChange,
                                                  object: nil)
    }
    
    @objc func dataChanged(notification: Notification) {
        for observer in observers {
            observer.dataChanged()
        }
    }
}


