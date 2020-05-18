//
//  AddRecordView.swift
//  TestApp
//
//  Created by Ruslan Maley on 18.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

class SaveRecordView: UIViewController {
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var revertButton: UIButton!
    
    var viewModel: AddRecordViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Private methods implementation
private extension SaveRecordView {
    func setup() {
        setupNavigationBar()
        setupViewModel()
    }
    
    func setupNavigationBar() {
        let backBarItem = UIBarButtonItem(title: Localization.Common.back.localized,
                                          style: .plain,
                                          target: self,
                                          action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem = backBarItem
    }
    
    func setupViewModel() {
        viewModel?.name.bindAndFire({ [unowned self] (name) in
        })
    }
}

// MARK: - Actions implementaion
private extension SaveRecordView {
    @IBAction func doneButtonPressed(sender: Any) {
        viewModel?.shouldAddItem()
    }
    
    @IBAction func revertButtonPressed(sender: Any) {
        viewModel?.shouldCancel()
    }
    
    @objc func backButtonPressed(sender: Any) {
        viewModel?.shouldMoveBack()
    }
}

// MARK: - UITextField methods implementation
extension SaveRecordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
