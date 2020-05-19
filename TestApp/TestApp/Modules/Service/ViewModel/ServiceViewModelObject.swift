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
    var error: Dynamic<TAError?> = .init(nil)
    var cellViewModels: Dynamic<[ServiceCellViewModel]>
    
    private let dao: ServiceDao
    
    init(dao: ServiceDao) {
        self.cellViewModels = .init([])
        
        self.dao = dao
    }
    
    func reloadData() {
        loadData()
    }
}

// MARK: - Private methods implementation
private extension ServiceViewModelObject {
    func loadData() {
        isLoading.value = true
        dao.loadObjects { [unowned self] (objects, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.error.value = error
                } else {
                    self.cellViewModels.value = self.viewModels(from: objects)
                }
                self.isLoading.value = false
            }
        }
    }
    
    func viewModels(from objects: [CD]) -> [ServiceCellViewModel] {
        return objects.map({ ServiceCellViewModelObject(cd: $0) })
    }
}
