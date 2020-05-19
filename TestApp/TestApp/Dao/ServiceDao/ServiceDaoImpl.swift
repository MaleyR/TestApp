//
//  ServiceDaoImpl.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

// Provides the wrapper for working with outer data source for Service tab
class ServiceDaoImpl {
    private let networkDao: NetworkService
    private let parser: Parser
    
    init(networkDao: NetworkService, parser: Parser) {
        self.networkDao = networkDao
        self.parser = parser
    }
}

extension ServiceDaoImpl: ServiceDao {
    func loadObjects(completion: @escaping (([CD], TAError?) -> Void)) {
        let request = GetCatalogRequest()
        networkDao.performRequest(request: request) { (result) in
            switch result {
            case .success(let data):
                self.parse(data: data) { (parsingResult) in
                    completion(parsingResult, nil)
                }
            case .failure(let error):
                completion([], error)
            }
        }
    }
}

private extension ServiceDaoImpl {
    func parse(data: Data, with completion: @escaping (([CD]) -> Void)) {
        self.parser.parse(data: data, with: completion)
    }
}
