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
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var checkmarkButton: UIButton!
    
    var viewModel: ListCellViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    var checkMarkSelected: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

// MARK: - Private methods implementation
private extension ListTableViewCell {
    func setup() {
        setupCheckmarkButton()
    }
    
    func setupCheckmarkButton() {
        checkmarkButton.layer.cornerRadius = 10
        checkmarkButton.layer.borderWidth = 1
        checkmarkButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func setupViewModel() {
        viewModel?.name.bindAndFire({ [unowned self] (name) in
            self.titleLabel.text = name
        })
        
        viewModel?.isSelected.bindAndFire({ [unowned self] (isSelected) in
            let checkmarkImage: UIImage? = isSelected ? UIImage(named: "checkmark_icon") : nil
            self.checkmarkButton.setImage(checkmarkImage, for: .normal)
            self.iconImageView.image = isSelected ? UIImage(named: "cell_selected_icon") : UIImage(named: "cell_not_selected_icon")
        })
    }
}

// MARK: - Actions implementation
private extension ListTableViewCell {
    @IBAction func checkmarkButtonPressed(sender: Any) {
        checkMarkSelected?()
    }
}


