//
//  Parser.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol Parser {
    func parse(data: Data, with completion: @escaping (([CD]) -> Void))
}
