//
//  ServiceCellViewModel.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

protocol ServiceCellViewModel {
    var title: String { get }
    var artist: String { get }
    var info: String { get }
    var price: String { get }
}
