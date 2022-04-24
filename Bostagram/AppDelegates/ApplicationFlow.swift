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
        let userProfileView = UserProfileViewController.instantiate(from: .UserProfile)
        setRootView(userProfileView)
    }

    private func setRootView(_ viewController: UIViewController) {
        guard let window = window else { return }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
