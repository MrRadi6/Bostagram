//
//  ApplicationFlow.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import UIKit

class ApplicationFlow {

    var window: UIWindow?

    static var shared = ApplicationFlow()

    private init() { }

    func launchApp() {
        let userProfileView = UserProfileNavigator.createModule()
        let rootViewController = UINavigationController(rootViewController: userProfileView)
        setRootView(rootViewController)
    }

    private func setRootView(_ viewController: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
