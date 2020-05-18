//
//  ListViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class ListViewModelObject: ListViewModel {
    private let dao: LoadDaoType & DeleteDaoType
    
    private var records: [Record] = []
    
    var cellViewModels: Dynamic<[ListCellViewModel]>
    
    var shouldAddNewItem: (() -> Void)?
    var shouldEditItem: ((String) -> Void)?
    
    init(dao: LoadDaoType & DeleteDaoType) {
        self.cellViewModels = Dynamic([])
        self.dao = dao
        self.loadData()
    }
    
    func shouldSelectItem(at index: Int) {
        shouldEditItem?(cellViewModels.value[index].name.value)
    }
    
    func shouldAddItem() {
        shouldAddNewItem?()
    }
    
    func shouldRemoveItem(at index: Int) {
        let record = records[index]
        dao.delete(record: record) { (error) in
            // Handle error
        }
    }
}

// MARK: - Private methods implementation
private extension ListViewModelObject {
    func loadData() {
        dao.loadItems { [unowned self] (records, error) in
            self.records = records
            self.cellViewModels = .init(self.viewModels(from: records))
        }
    }
    
    func viewModels(from records: [Record]) -> [ListCellViewModel] {
        return records.map({ ListCellViewModelObject(name: $0.name) })
    }
}

// Selection can be switched only from ListViewModelObject
fileprivate extension ListCellViewModel {
    func switchSelection() {
        isSelected.value = !isSelected.value
    }
}
