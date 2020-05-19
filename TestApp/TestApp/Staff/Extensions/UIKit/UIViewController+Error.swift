//
//  UIViewController+Error.swift
//  TestApp
//
//  Created by Ruslan Maley on 19.05.2020.
//  Copyright © 2020 Ruslan Maley. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ error: TAError) {
        let alert = UIAlertController(title: Localization.Common.errorTitle.localized,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Localization.Common.ok.localized,
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
