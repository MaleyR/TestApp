//
//  NetworkInterface.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol LoadDataDao {
    func loadData(completion: @escaping ((Result<Data, TAError>) -> Void))
}

protocol NetworkInterface {
    func performRequest(request: NetworkRequest, completion: @escaping ((Result<Data, TAError>) -> Void))
}
