//
//  ListCoordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class ListCoordinator: TabCoordinator {
    private struct Constants {
        struct Storyboard {
            static let name = "List"
            static let viewIdentifier = "ListView"
        }
    }
    
    var rootViewController: UIViewController {
        let controller = navigationController
        controller.tabBarItem = UITabBarItem(title: Localization.Tabs.list.localized,
                                             image: UIImage(named: "tab_list"),
                                             tag: 0)
        return controller
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: self.viewController)
        return navigationController
    }()
    
    private let storyboard = UIStoryboard(name: Constants.Storyboard.name,
                                                 bundle: Bundle(for: ListView.self))
    
    private lazy var viewController: UIViewController = {
        let view = self.storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewIdentifier)
        view.title = Localization.Tabs.list.localized
        return view
    }()
}
