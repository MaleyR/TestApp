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

extension DatabaseServiceImpl: AddDataDatabaseService {
    func save(object: [String : Any], completion: (TAError?) -> Void) {
        let context = persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.recordObjectName, in: context) else { return }
        let managedObject = RecordEntity(entity: entity, insertInto: context)
        fill(managedObject: managedObject, with: object)
        saveContext(completion: completion)
    }
}

extension DatabaseServiceImpl: UpdateDataDatabaseService {
    func update(id: Any, with object: [String : Any], completion: (TAError?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest(with: NSPredicate(format: "name = %@", id as! CVarArg))
        
        do {
            let result = try context.fetch(fetchRequest)
            
            guard let managedObject = result.first as? RecordEntity else { return }
            fill(managedObject: managedObject, with: object)
            saveContext(completion: completion)
        } catch {
            completion(.error(error))
        }
    }
}

extension DatabaseServiceImpl: DeleteDataDatabaseService {
    func delete(id: Any, completion: (TAError?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest(with: NSPredicate(format: "name = %@", id as! CVarArg))
        
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

extension DatabaseServiceImpl: LoadDataDatabaseService {
    func load(completion: ([[String : Any]], TAError?) -> Void) {
        let context = persistentContainer.viewContext
        let fetchRequest = self.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            let recordObjects = result as? [RecordEntity] ?? []
            
            var objects: [[String : Any]] = []
            
            for recordObject in recordObjects {
                objects.append(["name" : recordObject.value(forKey: "name") ?? ""])
            }
            
            completion(objects, nil)
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
    
    @discardableResult
    func fill(managedObject: RecordEntity, with object: [String : Any]) -> RecordEntity {
        for (key, value) in object {
            managedObject.setValue(value, forKey: key)
        }
        
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


