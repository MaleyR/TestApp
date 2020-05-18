//
//  ListViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class ListViewModelObject: ListViewModel {
    private var records: [Record] = []
    
    var cellViewModels: Dynamic<[ListCellViewModel]>
    
    init() {
        let object1 = ListCellViewModelObject(name: "name 1")
        let object2 = ListCellViewModelObject(name: "name 2")
        let object3 = ListCellViewModelObject(name: "name 3")
        self.cellViewModels = Dynamic([object1, object2, object3])
    }
    
    func shouldSelectRecord(at index: Int) {
        cellViewModels.value[index].switchSelection()
    }
}

// Selection can be switched only from ListViewModelObject
fileprivate extension ListCellViewModel {
    func switchSelection() {
        isSelected.value = !isSelected.value
    }
}
