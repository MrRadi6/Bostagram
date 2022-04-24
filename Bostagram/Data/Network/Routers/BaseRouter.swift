//
//  BaseRouter.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import Moya

protocol BaseRouter: TargetType {
    var baseURL: URL { get }
}

extension BaseRouter {
    var baseURL: URL {
        return URL(string: NetworkConstants.URL.base)!
    }
}
