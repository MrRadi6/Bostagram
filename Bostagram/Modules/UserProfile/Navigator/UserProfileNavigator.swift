//
//  UserProfileNavigator.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import UIKit

protocol UserProfileNavigatorProtocol {
    static func createModule() -> UserProfileViewController
    func openAlbum(_ album: Album)
}

class UserProfileNavigator: UserProfileNavigatorProtocol {
    weak var viewController: UIViewController?

    static func createModule() -> UserProfileViewController {
        let repository = UserRepository(remote: UserAPI())
        let useCase = UserProfileUseCase(repository: repository)
        let userProfileView = UserProfileViewController.instantiate(from: .UserProfile)
        let navigator = UserProfileNavigator()
        userProfileView.viewModel = UserProfileViewModel(useCase: useCase,
                                                         navigator: navigator)
        navigator.viewController = userProfileView
        return userProfileView
    }

    func openAlbum(_ album: Album) {
        let albumDetailsView = AlbumDetailsNavigator.createModule(with: album)
        viewController?.show(albumDetailsView, sender: nil)
    }
}
