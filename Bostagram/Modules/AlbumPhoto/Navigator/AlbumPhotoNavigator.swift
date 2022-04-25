//
//  AlbumPhotoNavigator.swift
//  Bostagram
//
//  Created by Samir on 4/25/22.
//

import Foundation
import UIKit

protocol AlbumPhotoNavigatorProtocol {
    static func createModule(photo: Photo) -> AlbumPhotoViewController
}

struct AlbumPhotoNavigator: AlbumPhotoNavigatorProtocol {
    weak var viewController: UIViewController?

    static func createModule(photo: Photo) -> AlbumPhotoViewController {
        let albumPhotoView = AlbumPhotoViewController.instantiate(from: .AlbumPhoto)
        let navigator =  AlbumDetailsNavigator()
        let viewModel = AlbumPhotoViewModel(navigator: navigator, photo: photo)
        albumPhotoView.viewModel = viewModel
        navigator.viewController = albumPhotoView
        return albumPhotoView
    }
}
