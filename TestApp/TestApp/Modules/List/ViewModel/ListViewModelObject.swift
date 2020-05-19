//
//  ListViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class ListViewModelObject: ListViewModel {
    private let dao: LoadDataService & DeleteDataService & LocalDataObserving
    
    private var records: [Record] = []
    
    var cellViewModels: Dynamic<[ListCellViewModel]>
    var error: Dynamic<TAError?>
    
    var shouldAddNewItem: (() -> Void)?
    var shouldEditItem: ((String) -> Void)?
    
    deinit {
        self.dao.removeDataObserver(self)
    }
    
    init(dao: LoadDataService & DeleteDataService & LocalDataObserving) {
        self.cellViewModels = Dynamic([])
        self.dao = dao
        self.error = .init(nil)
        self.loadData()
        
        self.dao.addDataObserver(self)
    }
    
    func shouldSelectItem(at index: Int) {
        shouldEditItem?(cellViewModels.value[index].name.value)
    }
    
    func shouldCheckItem(at index: Int) {
        let cellViewModel = cellViewModels.value[index]
        cellViewModel.isSelected.value = !cellViewModel.isSelected.value
    }
    
    func shouldAddItem() {
        shouldAddNewItem?()
    }
    
    func shouldRemoveItem(at index: Int) {
        let record = records[index]
        dao.delete(record: record) { [unowned self] (error) in
            self.error.value = error
        }
    }
}

// MARK: - Private methods implementation
private extension ListViewModelObject {
    func loadData() {
        dao.loadItems { [unowned self] (records, error) in
            self.records = records
            self.cellViewModels.value = self.viewModels(from: records.sorted(by: { $0.name < $1.name }))
        }
    }
    
    func viewModels(from records: [Record]) -> [ListCellViewModel] {
        return records.map({ ListCellViewModelObject(name: $0.name) })
    }
}

// MARK: - Implementation of data observer methods
extension ListViewModelObject: LocalDataObserver {
    func dataChanged() {
        loadData()
    }
}

// Selection can be switched only from ListViewModelObject
fileprivate extension ListCellViewModel {
    func switchSelection() {
        isSelected.value = !isSelected.value
    }
}
