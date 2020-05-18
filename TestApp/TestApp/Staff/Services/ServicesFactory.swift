//
//  ServicesFactory.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class ServicesFactory: Services {
    lazy var databaseDao: DatabaseDaoType = {
        return CoreDataDao()
    }()
    
    lazy var networkDao: NetworkInterface = {
        return NetworkDao()
    }()
    
    lazy var xmlParser: Parser = {
        return W3XMLParser()
    }()
}
