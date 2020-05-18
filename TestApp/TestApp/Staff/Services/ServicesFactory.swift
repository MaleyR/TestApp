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
}
