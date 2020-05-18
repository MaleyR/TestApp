//
//  ServiceTableViewCell.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    var viewModel: ServiceCellViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

private extension ServiceTableViewCell {
    func setup() {
        
    }
    
    func setupViewModel() {
        titleLabel.text = viewModel?.title
        artistLabel.text = viewModel?.artist
        infoLabel.text = viewModel?.info
        priceLabel.text = viewModel?.price
    }
}
