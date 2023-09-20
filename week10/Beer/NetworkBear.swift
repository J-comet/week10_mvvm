//
//  NetworkBear.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation
import Alamofire

class NetworkBear {
    
    static let shared = NetworkBear()
    private init() { }
    
    func request<T: Decodable>(
        api: BearAPI,
        type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(
            api.endpoint,
            method: api.method,            
            parameters: api.query,
            encoding: api.encoding
        )
        .validate(statusCode: 200...500)
        .responseDecodable(of: T.self) { response in
            print(response.request?.url)
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
    }
}
