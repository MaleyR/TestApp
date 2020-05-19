//
//  DatabaseService.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

typealias DatabaseOperationCompletion = ((TAError?) -> Void)
typealias DatabaseService = AddDataDatabaseService &
                            UpdateDataDatabaseService &
                            DeleteDataDatabaseService &
                            LoadDataDatabaseService &
                            LocalDataObserving

protocol AddDataDatabaseService {
    func save(object: [String : Any], completion: DatabaseOperationCompletion)
}

protocol UpdateDataDatabaseService {
    func update(id: Any, with object: [String : Any], completion: DatabaseOperationCompletion)
}

protocol DeleteDataDatabaseService {
    func delete(id: Any, completion: DatabaseOperationCompletion)
}

protocol LoadDataDatabaseService {
    func load(completion: ([[String : Any]], TAError?) -> Void)
}

// MARK: - Data changing observing
protocol LocalDataObserver: class {
    func dataChanged()
}

protocol LocalDataObserving {
    func addDataObserver(_ observer: LocalDataObserver)
    func removeDataObserver(_ observer: LocalDataObserver)
}
