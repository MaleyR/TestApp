//
//  ListView.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class ListView: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private struct Constants {
        static let cellIdentifier = "ListCell"
    }
    
    private var cellViewModels: [ListCellViewModel] = []
    
    var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Private extension implementation
private extension ListView {
    func setup() {
        setupNavigationBar()
        setupTableView()
        setupViewModel()
    }
    
    func setupNavigationBar() {
        let addButtonItem = UIBarButtonItem(title: Localization.List.add.localized,
                                            style: .plain,
                                            target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = addButtonItem
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func setupViewModel() {
        viewModel?.cellViewModels.bindAndFire({ [unowned self] (viewModels) in
            self.cellViewModels = viewModels
            self.tableView.reloadData()
        })
    }
}

// MARK: - Custom actions implementation
private extension ListView {
    @objc func addButtonPressed(sender: Any) {
        viewModel?.shouldAddItem()
    }
}

// MARK: - UITableViewDelegate methods implementation
extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.shouldSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editTitle = Localization.List.edit.localized
        let editAction = UIContextualAction(style: .normal,
                                            title: editTitle) { [unowned self] (_, _, success) in
                                                self.viewModel?.shouldSelectItem(at: indexPath.row)
                                                success(true)
        }
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTitle = Localization.List.delete.localized
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: deleteTitle) { [unowned self] (_, _, success) in
                                                self.viewModel?.shouldRemoveItem(at: indexPath.row)
                                                success(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

// MARK: - UITableViewDataSource methods implementation
extension ListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,
                                                 for: indexPath)
        
        if let requiredCell = cell as? ListTableViewCell {
            requiredCell.viewModel = cellViewModels[indexPath.row]
            requiredCell.checkMarkSelected = { [unowned self] in
                self.viewModel?.shouldCheckItem(at: indexPath.row)
            }
        }
        
        return cell
    }
}
