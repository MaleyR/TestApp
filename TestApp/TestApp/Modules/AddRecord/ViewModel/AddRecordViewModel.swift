//
//  AddRecordViewModel.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol AddRecordViewModel {
    var name: Dynamic<String> { get }
    var hasChanges: Dynamic<Bool> { get }
    
    func shouldAddItem()
    func shouldCancel()
    func shouldMoveBack()
    
    func nameChanged(_ name: String)
}
