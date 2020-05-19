//
//  TAError.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

// App specific errors
enum TAError: Error {
    case text(String)
    case error(Error)
}

// LocalizedError protocol implementation for providing error description
extension TAError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .text(let text):
            return text
        case .error(let error):
            return error.localizedDescription
        }
    }
}
