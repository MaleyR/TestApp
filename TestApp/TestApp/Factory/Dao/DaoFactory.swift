//
//  DaoFactory.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class DaoFactory: Dao {
    private let services: Services
    
    init(services: Services) {
        self.services = services
    }
    
    lazy var recordsDao: RecordsDao = {
        return RecordsDaoImpl(databaseService: services.databaseDao)
    }()
    
    lazy var serviceDao: ServiceDao = {
        return ServiceDao(networkDao: services.networkService, parser: W3XMLParser())
    }()
}
