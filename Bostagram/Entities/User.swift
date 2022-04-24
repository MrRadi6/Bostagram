//
//  User.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let address: Address

    struct Address: Decodable {
        let street: String
        let apt: String
        let city: String
        let zipCode: String

        enum CodingKeys: String, CodingKey {
            case street
            case apt = "suite"
            case city
            case zipCode = "zipcode"
        }
    }
}
