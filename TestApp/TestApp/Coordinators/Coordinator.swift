//
//  Coordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

protocol TabCoordinator {
    var rootViewController: UIViewController { get }
}
