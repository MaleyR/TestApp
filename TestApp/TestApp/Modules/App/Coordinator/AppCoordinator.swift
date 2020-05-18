//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

// The main app coordinator
// Calls on starting the app and provides the main view controller
class AppCoordinator: Coordinator {
    private let window: UIWindow
    private var childCoordinators: [TabCoordinator] = []
    
    private var services: Services = ServicesFactory()
    
    private lazy var tabBarController: UITabBarController = {
        let controller = UITabBarController()
        
        self.childCoordinators.append(listCoordinator())
        self.childCoordinators.append(serviceCoordinator())
        
        controller.viewControllers = self.childCoordinators.map({ $0.rootViewController })
        return controller
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        self.window.rootViewController = tabBarController
    }
}

private extension AppCoordinator {
    func listCoordinator() -> TabCoordinator {
        let coordinator = ListCoordinator(dao: services.databaseDao)
        return coordinator
    }
    
    func serviceCoordinator() -> ServiceCoordinator {
        let dao = ServiceDao(networkDao: services.networkDao, parser: services.xmlParser)
        let coordinator = ServiceCoordinator(dao: dao)
        return coordinator
    }
}
