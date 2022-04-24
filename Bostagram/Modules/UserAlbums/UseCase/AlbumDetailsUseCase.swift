//
//  AlbumDetailsUseCase.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import RxSwift

protocol AlbumDetailsUseCaseProtocol {
    func getPhotos(with userID: Int) -> Observable<[Photo]>
}

struct AlbumDetailsUseCase: AlbumDetailsUseCaseProtocol {
    let repository: UserRepositoryProtocol
    private let disposeBag = DisposeBag()

    func getPhotos(with userID: Int) -> Observable<[Photo]> {
        return .create { observer in
            repository.photos(albumID: userID) { result in
                switch result {
                case .success(let photos):
                    observer.onNext(photos)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
