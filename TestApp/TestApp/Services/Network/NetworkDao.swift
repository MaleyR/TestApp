//
//  NetworkService.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class NetworkDao: NetworkInterface {
    private let urlSession = URLSession(configuration: .default)
    
    func performRequest(request: NetworkRequest, completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = URL(string: request.path) else {
            // TODO: move error in completion
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                // TODO: move error in completion
            }
        }
        
        dataTask.resume()
    }
}
