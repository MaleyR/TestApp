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
            let viewModel = ListViewModelObject()
            viewModel.shouldManageItem = { [unowned self] name in
                self.openSaveRecordScreen(name: name ?? "")
            }
            
            requiredView.viewModel = viewModel
        }
        
        return view
    }()
    
    private let addItemStoryboard = UIStoryboard(name: Constants.Storyboard.AddItem.name,
                                                 bundle: Bundle(for: SaveRecordView.self))
}

// MARK: - Routing methods implementation
private extension ListCoordinator {
    func openSaveRecordScreen(name: String) {
        let navigationController = UINavigationController(rootViewController: saveRecordViewController(with: name))
        self.navigationController.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - Private methods implementation
private extension ListCoordinator {
    func saveRecordViewController(with name: String) -> UIViewController {
        let view = self.addItemStoryboard.instantiateViewController(withIdentifier: Constants.Storyboard.AddItem.viewIdentifier)
        
        if let requiredView = view as? SaveRecordView {
            let viewModel = AddRecordViewModelObject(name: name)
            viewModel.shouldFinish = { [unowned self] in
                self.navigationController.dismiss(animated: true, completion: nil)
            }
            requiredView.viewModel = viewModel
        }
        
        return view
    }
}
