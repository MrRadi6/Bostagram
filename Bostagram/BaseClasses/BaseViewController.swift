//
//  BaseViewController.swift
//  iTrack-Supervisor
//
//  Created by Marwa Salem on 10/04/2022.
//

import UIKit

class BaseViewController: UIViewController {

    private var loadingView: LoadingViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setViewTitleMode(isLarge: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = isLarge
    }
}

// MARK: - Conforming to BaseInteractorToPresenter
extension BaseViewController {

    func showError(title: String?, with message: String) {
        showErrorMessage(title: title, error: message)
    }

    func showLoadingView() {
        loadingView = LoadingViewController()
        loadingView!.modalPresentationStyle = .overCurrentContext
        loadingView!.modalTransitionStyle = .crossDissolve
        present(loadingView!, animated: true)
        loadingView!.startAnimating()
    }

    func hideLoadingView(completion: @escaping () -> Void) {
        loadingView?.stopAnimating()
        loadingView?.dismiss(animated: false) {
            completion()
        }
        loadingView = nil
    }
}
