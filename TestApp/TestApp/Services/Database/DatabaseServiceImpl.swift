//
//  DatabaseServiceImpl.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import CoreData

class DatabaseServiceImpl {
    private struct Constants {
        static let coreDataName = "TestApp"
        static let recordObjectName = "RecordEntity"
    }
    
    private var observers: [LocalDataObserver] = []
    
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
    
    private func saveContext(completion: ((TAError?) -> Void)) {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(TAError.text(Localization.Errors.databaseSavingContextError.localized))
            }
        }
    }
    
    deinit {
        observers.removeAll()
        unsubscribeFromDataChanges()
    }
}

// MARK: - AddDaoType methods implementation
extension DatabaseServiceImpl: AddDataService {
    func save(record: Record, completion: (TAError?) -> Void) {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.recordObjectName, in: context) else { return }
        let object = RecordEntity(entity: entity, insertInto: context)
        fill(managedObject: object, with: record)
        saveContext(completion: completion)
    }
}

// MARK: - UpdateDaoType methods implementation
extension DatabaseServiceImpl: UpdateDataService {
    func update(name: String, with record: Record, completion: (TAError?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest(with: NSPredicate(format: "name = %@", record.name))
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let object = result.first as? RecordEntity else { return }
            fill(managedObject: object, with: record)
            saveContext(completion: completion)
        } catch {
            completion(.error(error))
        }
    }
}

// MARK: - DeleteDaoType methods implementation
extension DatabaseServiceImpl: DeleteDataService {
    func delete(record: Record, completion: (TAError?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest(with: NSPredicate(format: "name = %@", record.name))
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let object = result.first as? RecordEntity else { return }
            context.delete(object)
            saveContext(completion: completion)
        } catch {
            completion(.error(error))
        }
    }
}

// MARK: - LoadDaoType methods implementation
extension DatabaseServiceImpl: LoadDataService {
    func loadItems(completion: (([Record], TAError?) -> Void)) {
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
            completion([], .error(error))
        }
    }
}

private extension DatabaseServiceImpl {
    func fetchRequest(with predicate: NSPredicate? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.recordObjectName)
        fetchRequest.predicate = predicate
        return fetchRequest
    }
}

// MARK: - Private extension for filling Core Data RecordEntity with Record model
private extension DatabaseServiceImpl {
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
extension DatabaseServiceImpl: LocalDataObserving {
    func addDataObserver(_ observer: LocalDataObserver) {
        if !observers.contains(where: { observer === $0 }) {
            observers.append(observer)
        }
    }
    
    func removeDataObserver(_ observer: LocalDataObserver) {
        guard let index = observers.firstIndex(where: { $0 === observer }) else { return }
        observers.remove(at: index)
    }
}

// MARK: - Data changing notifications handling
private extension DatabaseServiceImpl {
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


