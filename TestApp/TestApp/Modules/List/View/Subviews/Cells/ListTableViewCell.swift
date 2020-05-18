//
//  ListTableViewCell.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

// Class that provides the cell for table view at the List screen
class ListTableViewCell: UITableViewCell {
    var viewModel: ListCellViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Private methods implementation
private extension ListTableViewCell {
    func setupViewModel() {
        viewModel?.name.bindAndFire({ [unowned self] (name) in
            self.textLabel?.text = name
        })
        
        viewModel?.isSelected.bindAndFire({ [unowned self] (isSelected) in
            self.accessoryType = isSelected ? .checkmark : .none
            self.imageView?.image = isSelected ? UIImage(named: "cell_selected_icon") : UIImage(named: "cell_not_selected_icon")
        })
    }
}


