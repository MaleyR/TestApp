//
//  ListCellViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

struct ListCellViewModelObject: ListCellViewModel {
    var name: Dynamic<String>
    var isSelected: Dynamic<Bool>
    
    init(name: String) {
        self.name = .init(name)
        self.isSelected = .init(false)
    }
}
