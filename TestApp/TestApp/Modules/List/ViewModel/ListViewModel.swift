//
//  ListViewModel.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol ListViewModel {
    var cellViewModels: Dynamic<[ListCellViewModel]> { get }
    
    func shouldSelectRecord(at index: Int)
}
