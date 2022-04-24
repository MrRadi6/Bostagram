//
//  UserRepository.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation

protocol UserRepositoryProtocol {
    func users(completion: @escaping (Result<[User], Error>) -> Void)
    func albums(userID: Int, completion: @escaping (Result<[Album], Error>) -> Void)
    func photos(albumID: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
}

struct UserRepository: UserRepositoryProtocol {

    let remote: UserAPIProtocol

    func users(completion: @escaping (Result<[User], Error>) -> Void) {
        remote.users(completion: completion)
    }

    func albums(userID: Int, completion: @escaping (Result<[Album], Error>) -> Void) {
        remote.albums(userID: userID, completion: completion)
    }

    func photos(albumID: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        remote.photos(albumID: albumID, completion: completion)
    }
}
