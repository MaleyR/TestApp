//
//  SaveDataDecorator.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol SaveDataDecoratable {
    func save(name: String)
}

class AddItemDecorator: SaveDataDecoratable {
    private let decoratee: AddDaoType
    
    init(decoratee: AddDaoType) {
        self.decoratee = decoratee
    }
    
    func save(name: String) {
        decoratee.save(record: Record(name: name)) { (error) in
            // Handle error
        }
    }
}

class EditItemDecorator: SaveDataDecoratable {
    private let decoratee: UpdateDaoType
    private let name: String
    
    init(decoratee: UpdateDaoType, name: String) {
        self.decoratee = decoratee
        self.name = name
    }
    
    func save(name: String) {
        decoratee.update(name: self.name, with: Record(name: name)) { (error) in
            // Handle error
        }
    }
}


