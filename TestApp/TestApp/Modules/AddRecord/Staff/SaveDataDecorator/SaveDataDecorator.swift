//
//  SaveDataDecorator.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol SaveDataDecoratable {
    func save(name: String, completion: ((TAError?) -> Void))
}

class AddItemDecorator: SaveDataDecoratable {
    private let decoratee: AddDataService
    
    init(decoratee: AddDataService) {
        self.decoratee = decoratee
    }
    
    func save(name: String, completion: ((TAError?) -> Void)) {
        decoratee.save(record: Record(name: name), completion: completion)
    }
}

class EditItemDecorator: SaveDataDecoratable {
    private let decoratee: UpdateDataService
    private let name: String
    
    init(decoratee: UpdateDataService, name: String) {
        self.decoratee = decoratee
        self.name = name
    }
    
    func save(name: String, completion: ((TAError?) -> Void)) {
        decoratee.update(name: self.name, with: Record(name: name), completion: completion)
    }
}


