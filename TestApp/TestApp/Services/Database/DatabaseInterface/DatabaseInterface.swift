//
//  DatabaseInterface.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol DatabaseInterface {
    typealias DatabaseOperationCompletion = ((Error?) -> Void)
    
    func save(record: Record, completion: DatabaseOperationCompletion)
    func update(record: Record, completion: DatabaseOperationCompletion)
    func delete(record: Record, completion: DatabaseOperationCompletion)
    func loadItems(completion: (([Record], Error?) -> Void))
}
