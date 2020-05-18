//
//  Localization.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

// Provides an access to localized strings by constants
struct Localization {
    struct Tabs {
        static let list = "list"
        static let service = "service"
    }
    
    struct List {
        static let add = "add"
        static let edit = "edit"
        static let delete = "delete"
    }
    
    struct Common {
        static let back = "back"
        static let ok = "ok"
        static let cancel = "cancel"
    }
    
    struct SaveRecord {
        static let confirmationAlertTitle = "warning"
        static let confirmationAlertText = "save_confirmation"
    }
}
