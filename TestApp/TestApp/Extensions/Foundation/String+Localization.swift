//
//  String+Localization.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

// This extension was added to decrease the code size
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
