//
//  ServiceViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class ServiceViewModelObject: ServiceViewModel {
    var isLoading: Dynamic<Bool> = .init(false)
    var cellViewModels: Dynamic<[ServiceCellViewModel]>
    
    init() {
        self.cellViewModels = .init([])
    }
}
