//
//  UIViewController+Extension.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import UIKit

extension UIViewController: StoryboardInstantiable {}

extension UIViewController {
    func showErrorMessage(title: String?, error: String) {
        let alert = UIAlertController(title: title,
                                      message: error,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "global_cancel_title".localized(), style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}
