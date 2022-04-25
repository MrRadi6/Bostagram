//
//  AlbumDetailsNavigator.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import UIKit

protocol AlbumDetailsNavigatorProtocol {
    static func createModule(with album: Album) -> AlbumDetailsViewController
    func openPhoto(_ photo: Photo)
}

class AlbumDetailsNavigator: AlbumDetailsNavigatorProtocol {
    weak var viewController: UIViewController?

    static func createModule(with album: Album) -> AlbumDetailsViewController {
        let repository = UserRepository(remote: UserAPI())
        let useCase = AlbumDetailsUseCase(repository: repository)
        let albumDetailsView = AlbumDetailsViewController.instantiate(from: .AlbumDetails)
        let navigator = AlbumDetailsNavigator()
        albumDetailsView.viewModel = AlbumDetailsViewModel(useCase: useCase,
                                                           navigator: navigator,
                                                           album: album)
        navigator.viewController = albumDetailsView
        return albumDetailsView
    }

    func openPhoto(_ photo: Photo) {
        let albumPhotoView = AlbumPhotoNavigator.createModule(photo: photo)
        viewController?.show(albumPhotoView, sender: nil)
    }
}
