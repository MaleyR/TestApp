//
//  RecordsDao.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

typealias RecordsDao = AddRecordsDao & UpdateRecordsDao & DeleteRecordsDao & LoadRecordsDao & LocalDataObserving

protocol AddRecordsDao {
    func save(record: Record, completion: DatabaseOperationCompletion)
}

protocol UpdateRecordsDao {
    func update(name: String, with record: Record, completion: DatabaseOperationCompletion)
}

protocol DeleteRecordsDao {
    func delete(record: Record, completion: DatabaseOperationCompletion)
}

protocol LoadRecordsDao {
    func loadItems(completion: (([Record], TAError?) -> Void))
}
