//
//  ListCoordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class ListCoordinator: TabCoordinator {
    var rootViewController: UIViewController {
        let controller = navigationController
        controller.tabBarItem = UITabBarItem(title: Localization.Tabs.list.localized,
                                             image: UIImage(named: "tab_list"),
                                             tag: 0)
        return controller
    }
    
    private lazy var navigationController: UINavigationController = {
        return UINavigationController()
    }()
}
