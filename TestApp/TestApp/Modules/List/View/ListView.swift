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
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView() {
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func setupViewModel() {
        viewModel?.cellViewModels.bindAndFire({ [unowned self] (viewModels) in
            self.cellViewModels = viewModels
            self.tableView.reloadData()
        })
    }
}

// MARK: - UITableViewDelegate methods implementation
extension ListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.shouldSelectRecord(at: indexPath.row)
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
        }
        
        return cell
    }
}
