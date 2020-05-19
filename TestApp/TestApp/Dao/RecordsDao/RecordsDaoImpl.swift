//
//  RecordsDaoImpl.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class RecordsDaoImpl: RecordsDao {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService) {
        self.databaseService = databaseService
    }
    
    func save(record: Record, completion: (TAError?) -> Void) {
        self.databaseService.save(object: ["name" : record.name], completion: completion)
    }
    
    func update(name: String, with record: Record, completion: (TAError?) -> Void) {
        self.databaseService.update(id: name, with: ["name" : record.name], completion: completion)
    }
    
    func delete(record: Record, completion: (TAError?) -> Void) {
        self.databaseService.delete(id: record.name, completion: completion)
    }
    
    func loadItems(completion: (([Record], TAError?) -> Void)) {
        self.databaseService.load { (objects, error) in
            let records = objects.map({ Record(name: $0["name"] as? String ?? "") })
            completion(records, error)
        }
    }
}

// MARK: - LocalDataObserving implementation
extension RecordsDaoImpl {
    func addDataObserver(_ observer: LocalDataObserver) {
        self.databaseService.addDataObserver(observer)
    }
    
    func removeDataObserver(_ observer: LocalDataObserver) {
        self.databaseService.removeDataObserver(observer)
    }
}
