//
//  NetworkConstants.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation

enum NetworkConstants {
    enum URL {
        static let base = "https://jsonplaceholder.typicode.com"
    }

    enum Header {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let json = "application/json"
    }

    enum Path {
        static let users = "users"
        static let albums = "albums"
        static let photos = "photos"
    }

    enum Parameter {
        static let userID = "userId"
        static let albumID = "albumId"
    }
}
