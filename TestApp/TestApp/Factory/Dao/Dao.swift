//
//  Dao.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol Dao {
    var recordsDao: RecordsDao { get }
    var serviceDao: ServiceDao { get }
}
