//
//  Services.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol Services {
    var databaseDao: DatabaseService { get }
    var networkService: NetworkService { get }
}
