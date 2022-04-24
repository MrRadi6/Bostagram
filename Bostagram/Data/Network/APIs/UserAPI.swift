//
//  UserAPI.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import Moya

struct UserAPI: BaseAPI {
    typealias router = UserRouter

    func users(completion: @escaping (Result<[User], Error>) -> Void) {
        makeRequest(target: .users) { (result: Result<[User], Error>) in
            switch result {
            case .success(let users):
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func albums(userID: Int, completion: @escaping (Result<[Album], Error>) -> Void) {
        makeRequest(target: .albums(userID: userID)) { (result: Result<[Album], Error>) in
            switch result {
            case .success(let albums):
                completion(.success(albums))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func photos(albumID: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
        makeRequest(target: .photos(albumID: albumID)) { (result: Result<[Photo], Error>) in
            switch result {
            case .success(let photos):
                completion(.success(photos))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
