//
//  GetCatalogRequest.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import Foundation

struct GetCatalogRequest: NetworkRequest {
    var path: String = "https://www.w3schools.com/xml/cd_catalog.xml"
}
