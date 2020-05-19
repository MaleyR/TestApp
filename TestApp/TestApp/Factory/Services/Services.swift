//
//  Services.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

typealias DatabaseDaoType = AddDaoType & UpdateDaoType & DeleteDaoType & LoadDaoType & DaoDataObserving

protocol Services {
    var databaseDao: DatabaseDaoType { get }
    var networkDao: NetworkInterface { get }
}
