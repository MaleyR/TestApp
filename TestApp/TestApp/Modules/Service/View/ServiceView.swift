//
//  ServiceView.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class ServiceView: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private struct Constants {
        static let cellIdentifier = "Service Cell"
    }
    
    var cellViewModels: [ServiceCellViewModel] = []
    
    var viewModel: ServiceViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewModel?.reloadData()
    }
}

// MARK: - Private methods implementation
private extension ServiceView {
    func setup() {
        setupTableView()
        setupViewModel()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: String(describing: ServiceTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func setupViewModel() {
        viewModel?.isLoading.bind({ [unowned self] (isLoading) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        })
        
        viewModel?.cellViewModels.bindAndFire({ [unowned self] (cellViewModels) in
            self.cellViewModels = cellViewModels
            self.tableView.reloadData()
        })
    }
}

// MARK: - UITableViewDataSource methods implementation
extension ServiceView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        if let requiredCell = cell as? ServiceTableViewCell {
            requiredCell.viewModel = cellViewModels[indexPath.row]
        }
        
        return cell
    }
}
