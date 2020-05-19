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
    
    func performRequest(request: NetworkRequest, completion: @escaping ((Result<Data, TAError>) -> Void)) {
        guard let url = URL(string: request.path) else {
            completion(.failure(.text(Localization.Errors.networkUrlError.localized)))
            return
        }
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.text(Localization.Errors.networkRequestError.localized)))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.text(Localization.Errors.networkRequestError.localized)))
            }
        }
        
        dataTask.resume()
    }
}
