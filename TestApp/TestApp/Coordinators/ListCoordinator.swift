//
//  ListCoordinator.swift
//  TestApp
//
//  Created by Ruslan Maley on 17.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

// List tab coordinator
// NOTE: Maybe it will be needed to add router later to move transition logic there
class ListCoordinator: TabCoordinator {
    private struct Constants {
        struct Storyboard {
            struct List {
                static let name = "List"
                static let viewIdentifier = "ListView"
            }
            struct AddItem {
                static let name = "AddRecord"
                static let viewIdentifier = "AddRecordView"
            }
        }
    }
    
    private let services: Services
    private let dao: Dao
    
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
    
    private let listStoryboard = UIStoryboard(name: Constants.Storyboard.List.name,
                                              bundle: Bundle(for: ListView.self))
    
    private lazy var viewController: UIViewController = {
        let view = self.listStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.List.viewIdentifier)
        view.title = Localization.Tabs.list.localized
        
        if let requiredView = view as? ListView {
            let viewModel = ListViewModelObject(dao: self.dao.recordsDao)
            viewModel.shouldAddNewItem = { [unowned self] in
                self.openAddRecordScreen()
            }
            viewModel.shouldEditItem = { [unowned self] name in
                self.openEditRecordScreen(name: name)
            }
            
            requiredView.viewModel = viewModel
        }
        
        return view
    }()
    
    private let addItemStoryboard = UIStoryboard(name: Constants.Storyboard.AddItem.name,
                                                 bundle: Bundle(for: SaveRecordView.self))
    
    init(services: Services, dao: Dao) {
        self.services = services
        self.dao = dao
    }
}

// MARK: - Routing methods implementation
private extension ListCoordinator {
    func openAddRecordScreen() {
        let decorator = AddItemDecorator(decoratee: self.dao.recordsDao)
        presentWithNavigation(viewController: saveRecordViewController(decorator: decorator))
    }
    
    func openEditRecordScreen(name: String) {
        let decorator = EditItemDecorator(decoratee: self.dao.recordsDao, name: name)
        presentWithNavigation(viewController: saveRecordViewController(with: name, decorator: decorator))
    }
    
    func presentWithNavigation(viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Private methods implementation
private extension ListCoordinator {
    func saveRecordViewController(with name: String = "", decorator: SaveDataDecoratable) -> UIViewController {
        let view = self.addItemStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.AddItem.viewIdentifier)
        
        if let requiredView = view as? SaveRecordView {
            let viewModel = AddRecordViewModelObject(name: name, daoDecorator: decorator)
            viewModel.shouldFinish = { [unowned self] in
                self.navigationController.dismiss(animated: true, completion: nil)
            }
            requiredView.viewModel = viewModel
        }
        
        return view
    }
}
