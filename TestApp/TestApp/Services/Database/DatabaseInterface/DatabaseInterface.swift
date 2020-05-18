//
//  DatabaseInterface.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

typealias DatabaseOperationCompletion = ((Error?) -> Void)

protocol AddDaoType {
    func save(record: Record, completion: DatabaseOperationCompletion)
}

protocol UpdateDaoType {
    func update(name: String, with record: Record, completion: DatabaseOperationCompletion)
}

protocol DeleteDaoType {
    func delete(record: Record, completion: DatabaseOperationCompletion)
}

protocol LoadDaoType {
    func loadItems(completion: (([Record], Error?) -> Void))
}
