//
//  AlbumDetailsViewModel.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol AlbumDetailsViewModelProtocol {
    var viewDidLoad: PublishSubject<Void> { get }
    var album: PublishSubject<Album> { get }
    var filterPhotos: PublishSubject<[Photo]> { get }
    var searchPhotos: PublishSubject<String> { get }
    var selectPhoto: PublishSubject<Int> { get }
}

struct AlbumDetailsViewModel: AlbumDetailsViewModelProtocol {

    private let useCase: AlbumDetailsUseCaseProtocol
    private let navigator: AlbumDetailsNavigatorProtocol

    private let disposeBag = DisposeBag()

    private let allPhotos = PublishSubject<[Photo]>()
    let viewDidLoad = PublishSubject<Void>()
    let album = PublishSubject<Album>()
    let filterPhotos = PublishSubject<[Photo]>()
    let searchPhotos = PublishSubject<String>()
    let selectPhoto = PublishSubject<Int>()


    init(useCase: AlbumDetailsUseCaseProtocol,
         navigator: AlbumDetailsNavigatorProtocol,
         album: Album) {
        self.useCase = useCase
        self.navigator = navigator
        setupViewDidLoadObserver(with:  album)
        setupSelectPhoto()
        setupSearchPhoto()
    }

    private func setupViewDidLoadObserver(with album: Album) {
        viewDidLoad.subscribe { _ in
            self.album.onNext(album)
            getPhotos(with: album)
        }
        .disposed(by: disposeBag)
    }

    private func getPhotos(with album: Album) {
        useCase.getPhotos(with: album.userID)
            .bind(onNext: { photos in
                allPhotos.onNext(photos)
                filterPhotos.onNext(photos)
            })
            .disposed(by: disposeBag)
    }

    private func setupSelectPhoto() {
        selectPhoto.withLatestFrom(filterPhotos) { (index, photos) -> Photo in
            return photos[index]
        }
        .bind { photo in
            navigator.openPhoto(photo)
        }
        .disposed(by: disposeBag)
    }

    private func setupSearchPhoto() {
        searchPhotos.withLatestFrom(allPhotos) { (searchKey, photos) -> [Photo] in
            guard !searchKey.isEmpty else {
                return photos
            }
            return photos.filter({ $0.title.lowercased().starts(with: searchKey.lowercased()) })
        }
        .subscribe(filterPhotos)
        .disposed(by: disposeBag)
    }
}
