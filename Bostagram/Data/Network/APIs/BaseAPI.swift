//
//  BaseAPI.swift
//  Bostagram
//
//  Created by Samir on 4/24/22.
//

import Foundation
import Moya

protocol BaseAPI {
    associatedtype router: BaseRouter
    func makeRequest<D: Decodable>(target: router, completion: @escaping (Result<D, Error>) -> Void)
}

extension BaseAPI {
    func makeRequest<D: Decodable>(target: router, completion: @escaping (Result<D, Error>) -> Void) {
        let provider = MoyaProvider<router>()
        provider.request(target, callbackQueue: DispatchQueue.main) { result in
            switch result {
            case .success(let response):
                do {
                    let successResponse = try response.filter(statusCodes: 200...299)
                    let data = try successResponse.map(D.self)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
