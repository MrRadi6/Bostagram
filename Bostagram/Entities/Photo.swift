//
//  Photo.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation

struct Photo: Decodable {
    let albumID: Int
    let id: Int
    let title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id
        case title
        case url
    }
}
