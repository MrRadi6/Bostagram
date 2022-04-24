//
//  Album.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation

struct Album: Decodable {
    let userID: Int
    let id: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
    }
}
