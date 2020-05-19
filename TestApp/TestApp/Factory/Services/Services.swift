//
//  Services.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

// Interface that provides an access to outer data sources (network, database etc)
protocol Services {
    var databaseDao: DatabaseService { get }
    var networkService: NetworkService { get }
}
