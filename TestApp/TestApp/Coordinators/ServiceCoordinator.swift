//
//  ServiceCoordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

// Service tab coordinator
class ServiceCoordinator: TabCoordinator {
    private struct Constants {
        struct Storyboard {
            static let name = "Service"
            static let viewIdentifier = "ServiceView"
        }
    }
    
    private let dao: Dao
    
    var rootViewController: UIViewController {
        let viewController = navigationController
        viewController.tabBarItem = UITabBarItem(title: Localization.Tabs.service.localized,
                                                 image: UIImage(named: "tab_service"),
                                                 tag: 1)
        return viewController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController(rootViewController: self.viewController)
        return navigationController
    }()
    
    private let storyboard = UIStoryboard(name: Constants.Storyboard.name,
                                          bundle: Bundle(for: ServiceView.self))
    
    private lazy var viewController: UIViewController = {
        let viewController = self.storyboard.instantiateViewController(withIdentifier: Constants.Storyboard.viewIdentifier)
        viewController.title = Localization.Tabs.service.localized
        
        if let requiredViewController = viewController as? ServiceView {
            let viewModel = ServiceViewModelObject(dao: dao.serviceDao)
            requiredViewController.viewModel = viewModel
        }
        
        return viewController
    }()
    
    init(dao: Dao) {
        self.dao = dao
    }
}
