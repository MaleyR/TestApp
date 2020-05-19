//
//  DatabaseService.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

typealias DatabaseOperationCompletion = ((TAError?) -> Void)

protocol AddDataService {
    func save(record: Record, completion: DatabaseOperationCompletion)
}

protocol UpdateDataService {
    func update(name: String, with record: Record, completion: DatabaseOperationCompletion)
}

protocol DeleteDataService {
    func delete(record: Record, completion: DatabaseOperationCompletion)
}

protocol LoadDataService {
    func loadItems(completion: (([Record], TAError?) -> Void))
}

// MARK: - Data changing observing
protocol LocalDataObserver: class {
    func dataChanged()
}

protocol LocalDataObserving {
    func addDataObserver(_ observer: LocalDataObserver)
    func removeDataObserver(_ observer: LocalDataObserver)
}
