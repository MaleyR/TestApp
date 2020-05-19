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
    var error: Dynamic<TAError?> { get }
    
    func shouldSelectItem(at index: Int)
    func shouldCheckItem(at index: Int)
    func shouldAddItem()
    func shouldRemoveItem(at index: Int)
}
