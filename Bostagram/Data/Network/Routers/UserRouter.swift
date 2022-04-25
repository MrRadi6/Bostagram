//
//  UserRouter.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import Moya

enum UserRouter {
    case users
    case albums(userID: Int)
    case photos(albumID: Int)
}

// MARK: - Conforming to BaseRouter
extension UserRouter: BaseRouter {
    var path: String {
        switch self {
        case .users:
            return NetworkConstants.Path.users
        case .albums:
            return NetworkConstants.Path.albums
        case .photos:
            return NetworkConstants.Path.photos
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .users:
            return .requestPlain
        case .albums(let userID):
            return .requestParameters(parameters: [NetworkConstants.Parameter.userID: userID], encoding: URLEncoding.default)
        case .photos(let albumID):
            return .requestParameters(parameters: [NetworkConstants.Parameter.albumID: albumID], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return [NetworkConstants.Header.contentType: NetworkConstants.ContentType.json]
    }
}
