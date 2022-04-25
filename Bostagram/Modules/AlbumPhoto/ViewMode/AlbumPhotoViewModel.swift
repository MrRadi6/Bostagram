//
//  AlbumPhotoViewModel.swift
//  Bostagram
//
//  Created by Samir on 4/25/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol AlbumPhotoViewModelProtocol {
    var viewDidLoad: PublishSubject<Void> { get }
    var photo: PublishSubject<Photo> { get }
}

struct AlbumPhotoViewModel: AlbumPhotoViewModelProtocol {

    let navigator: AlbumDetailsNavigatorProtocol
    let viewDidLoad = PublishSubject<Void>()
    let photo = PublishSubject<Photo>()

    private let disposeBag = DisposeBag()
    
    init(navigator: AlbumDetailsNavigatorProtocol,
         photo: Photo) {
        self.navigator = navigator
        setupViewDidLoad(with: photo)
    }

    private func setupViewDidLoad(with photo: Photo) {
        viewDidLoad.bind { _ in
            self.photo.onNext(photo)
        }
        .disposed(by: disposeBag)
    }
}
