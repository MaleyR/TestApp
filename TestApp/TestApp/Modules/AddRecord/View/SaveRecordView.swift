//
//  SaveRecordView.swift
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
            self.textField.text = name
        })
        
        viewModel?.hasChanges.bind({ [unowned self] (hasChanges) in
            if hasChanges {
                self.showConfirmationAlert()
            }
        })
    }
    
    func showConfirmationAlert() {
        let alert = UIAlertController(title: Localization.SaveRecord.confirmationAlertTitle.localized,
                                      message: Localization.SaveRecord.confirmationAlertText.localized,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.Common.ok.localized,
                                     style: .default) { [unowned self] (_) in
                                        self.viewModel?.shouldAddItem()
        }
        let cancelAction = UIAlertAction(title: Localization.Common.cancel.localized,
                                         style: .cancel) { [unowned self] (_) in
                                            self.viewModel?.shouldCancel()
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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
        self.view.endEditing(true)
        viewModel?.shouldMoveBack()
    }
}

// MARK: - UITextField methods implementation
extension SaveRecordView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel?.nameChanged(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
