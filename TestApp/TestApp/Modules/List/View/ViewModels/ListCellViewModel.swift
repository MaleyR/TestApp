//
//  ListCellViewModel.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol ListCellViewModel {
    var name: Dynamic<String> { get }
    var isSelected: Dynamic<Bool> { get }
}
