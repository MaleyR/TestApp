//
//  ServiceViewModel.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol ServiceViewModel {
    var isLoading: Dynamic<Bool> { get }
    
    var cellViewModels: Dynamic<[ServiceCellViewModel]> { get }
}
