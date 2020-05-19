//
//  ServicesFactory.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

// Class for building classes for working with outer services
class ServicesFactory: Services {
    lazy var databaseDao: DatabaseService = {
        return DatabaseServiceImpl()
    }()
    
    lazy var networkService: NetworkService = {
        return NetworkServiceImpl()
    }()
}
