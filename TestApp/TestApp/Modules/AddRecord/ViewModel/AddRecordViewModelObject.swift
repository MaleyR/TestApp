//
//  AddRecordViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class AddRecordViewModelObject: AddRecordViewModel {
    private var newName: String
    
    var name: Dynamic<String>
    var hasChanges: Dynamic<Bool>
    
    var shouldFinish: (() -> Void)?
    
    init(name: String) {
        self.name = .init(name)
        self.hasChanges = .init(false)
        self.newName = name
    }
    
    func shouldAddItem() {
        // TODO: add data to database
    }
    
    func shouldCancel() {
        shouldFinish?()
    }
    
    func shouldMoveBack() {
        hasChanges.value = newName != name.value
        
        if !hasChanges.value {
            shouldFinish?()
        }
    }
    
    func nameChanged(_ name: String) {
        newName = name
    }
}
