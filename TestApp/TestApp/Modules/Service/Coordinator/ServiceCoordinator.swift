//
//  ServiceCoordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class ServiceCoordinator: TabCoordinator {
    var rootViewController: UIViewController {
        let viewController = navigationController
        viewController.tabBarItem = UITabBarItem(title: Localization.Tabs.service.localized,
                                                 image: UIImage(named: "tab_service"),
                                                 tag: 1)
        return viewController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
}
