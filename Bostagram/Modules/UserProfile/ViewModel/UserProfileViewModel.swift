//
//  UserProfileViewModel.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import RxSwift
import RxCocoa

struct UserProfileViewModel {

    private let useCase: UserProfileUseCaseProtocol
    private let navigator: UserProfileNavigatorProtocol
    
    private let disposeBag = DisposeBag()

    let viewDidLoad = PublishSubject<Void>()
    let selectAlbum = PublishSubject<Int>()
    let user = PublishSubject<User>()
    let albums = PublishSubject<[Album]>()

    init(useCase: UserProfileUseCaseProtocol,
         navigator: UserProfileNavigatorProtocol) {
        self.useCase = useCase
        self.navigator = navigator
        setupViewDidLoadObserver()
        setupAlbumSelection()
    }

    private func setupViewDidLoadObserver() {
        viewDidLoad.subscribe { _ in
            getUser()
        }
        .disposed(by: disposeBag)
    }

    private func getUser() {
        useCase.getUser()
            .bind(onNext: { user in
                getAlbums(for: user)
                self.user.onNext(user)
            })
        .disposed(by: disposeBag)
    }

    private func getAlbums(for user: User) {
        useCase.getUserAlbums(with: user.id)
            .subscribe(albums)
            .disposed(by: disposeBag)
    }

    private func setupAlbumSelection() {
        selectAlbum.withLatestFrom(albums) { (index, albums) -> Album in
            return albums[index]
        }.bind(onNext: { album in
            self.navigator.openAlbum(album)
        })
        .disposed(by: disposeBag)
    }
}
