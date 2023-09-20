//
//  Network.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation
import Alamofire

class Network {
    static let shared = Network()
    private init() { }
    
    // Router 로 통신 - private 으로 열거형내에서 모든 데이터를 관리 = 통신 관련은 외부에서 접근할 수 없게 관리
    func requestConvertible<T: Decodable>(
        api: Router,
        type: T.Type,
        completion: @escaping (Result<T, SeSACError>) -> Void
    ) {
        AF.request(api).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? SeSACError.invalidServer.rawValue
                guard let sesacError = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(sesacError))
            }
        }
    }
    
    // UnsplashAPI 로 통신
    func request<T: Decodable>(
        api: UnsplashAPI,
        type: T.Type,
        completion: @escaping (Result<T, SeSACError>) -> Void
    ) {
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.query,
            encoding: URLEncoding(destination: .queryString),
            headers: api.header
        )
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? SeSACError.invalidServer.rawValue
                guard let sesacError = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(sesacError))
            }
        }
    }
}
