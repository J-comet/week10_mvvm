//
//  NetworkBasic.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation
import Alamofire

enum SeSACError: Int, Error, LocalizedError {
    case unauthorized = 401
    case permissionDenied = 403
    case invalidServer = 500
    case missingParameter = 400
    
    var errorDescription: String {
        switch self {
        case .unauthorized:
            return "인증정보가 없어요"
        case .permissionDenied:
            return "권한이 없어요"
        case .invalidServer:
            return "서버 점검 중이에요"
        case .missingParameter:
            return "검색어를 입력해주세요"
        }
    }
}

final class NetworkBasic {
    
    static let shared = NetworkBasic()
    private init() { }
    
    // Result<Photo, Error> -> 애플에서 제공하는 Result Enum 을 사용해서 성공 or 실패에 대해서만 대응할 수 있도록
    func searchPhotos(api: UnsplashAPI, query: String, completion: @escaping (Result<Photo, SeSACError>) -> Void) {
//        let api = UnsplashAPI.search(query: query)
//        let query: Parameters = ["query": query]
//        guard let url = URL(string: "https://api.unsplash.com/search/photos") else { return }
        
        // encoding 으로 get 일 때도 파라미터를 사용할 수 있도록 함 - parameters = 원래 POST 에서 쓰던방식
        AF.request(
            api.endpoint,
            method: api.method,
            parameters: api.query,
            encoding: URLEncoding(destination: .queryString),
            headers: api.header
        )
        .responseDecodable(of: Photo.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(_):
                let statusCode = response.response?.statusCode ?? 500
                guard let sesacError = SeSACError(rawValue: statusCode) else { return }
                completion(.failure(sesacError))
            }
        }
    }
    
    func random(api: UnsplashAPI, completion: @escaping (PhotoResult?, SeSACError?) -> Void) {
//        let api = UnsplashAPI.random
        //        guard let url = URL(string: "https://api.unsplash.com/photos/random") else { return }
        
        // encoding 으로 get 일 때도 파라미터를 사용할 수 있도록 함 - parameters = 원래 POST 에서 쓰던방식
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data):
                    completion(data, nil)
                case .failure( _):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let sesacError = SeSACError(rawValue: statusCode) else { return }
                    completion(nil, sesacError)
                }
            }
    }
    
    func detailPhoto(api: UnsplashAPI, id: String, completion: @escaping (Result<PhotoResult, SeSACError>) -> Void) {
//        let api = UnsplashAPI.photo(id: id)
        //        guard let url = URL(string: "https://api.unsplash.com/photos/\(id)") else { return }
        
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .responseDecodable(of: PhotoResult.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure( _):
                    let statusCode = response.response?.statusCode ?? 500
                    guard let sesacError = SeSACError(rawValue: statusCode) else { return }
                    completion(.failure(sesacError))
                }
            }
    }
}
