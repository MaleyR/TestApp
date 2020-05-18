//
//  AddRecordViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class AddRecordViewModelObject: AddRecordViewModel {
    private let daoDecorator: SaveDataDecoratable
    
    private var newName: String
    
    var name: Dynamic<String>
    var hasChanges: Dynamic<Bool>
    
    var shouldFinish: (() -> Void)?
    
    init(name: String, daoDecorator: SaveDataDecoratable) {
        self.name = .init(name)
        self.hasChanges = .init(false)
        self.newName = name
        self.daoDecorator = daoDecorator
    }
    
    func shouldAddItem() {
        daoDecorator.save(name: newName)
        shouldFinish?()
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
