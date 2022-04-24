//
//  UserProfileUseCase.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import RxSwift

protocol UserProfileUseCaseProtocol {
    func getUser() -> Observable<User>
    func getUserAlbums(with userID: Int) -> Observable<[Album]>
}

struct UserProfileUseCase: UserProfileUseCaseProtocol {
    let repository: UserRepositoryProtocol
    private let disposeBag = DisposeBag()

    func getUser() -> Observable<User> {
        return .create { observer in
            repository.users { result in
                switch result {
                case .success(let users):
                    let user = users[Int.random(in: 0..<users.count)]
                    observer.onNext(user)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    func getUserAlbums(with userID: Int) -> Observable<[Album]> {
        return .create { observer in
            repository.albums(userID: userID) { result in
                switch result {
                case .success(let albums):
                    observer.onNext(albums)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
