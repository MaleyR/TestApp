//
//  NetworkService.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol NetworkService {
    func performRequest(request: NetworkRequest, completion: @escaping ((Result<Data, TAError>) -> Void))
}
