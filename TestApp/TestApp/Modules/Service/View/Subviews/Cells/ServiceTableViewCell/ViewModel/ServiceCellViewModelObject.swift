//
//  ServiceCellViewModelObject.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

class ServiceCellViewModelObject: ServiceCellViewModel {
    private let cd: CD
    
    var title: String
    var artist: String
    var info: String
    var price: String
    
    init(cd: CD) {
        self.cd = cd
        self.title = cd.title
        self.artist = cd.artist
        self.price = "$" + cd.price
        self.info = "\(cd.country), \(cd.company), \(cd.year)"
    }
}
