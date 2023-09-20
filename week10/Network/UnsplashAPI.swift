//
//  UnsplashAPI.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation
import Alamofire

// UnsplashAPI 구조를 쉽게 만들도록 도와주는 Alamofire 에서 제공해주는 녀석
//enum Router: URLRequestConvertible {
//    func asURLRequest() throws -> URLRequest {
//        return URLRequest(url: ., method: <#T##HTTPMethod#>)
//    }
//}

enum UnsplashAPI {
    
    private static let key = "v5xVYXamHA8lxYD692kNCwXiS5A7N3ZiYTe6UdDNL_Y"
    
    case search(query: String)
    case random
    case photo(id: String)  // 열거형 연관 값 -> associated value
    
    private var baseURL: String {
        switch self {
        case .search:
            return "https://api.unsplash.com/"
        case .random:
            return "https://api.unsplash.com/"
        case .photo:
            return "https://api.unsplash.com/"
        }
    }
    
    var endpoint: URL {
        switch self {
        case .search:
            return URL(string: baseURL + "search/photos")!
        case .random:
            return URL(string: baseURL + "photos/random")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(UnsplashAPI.key)"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .random:
            return .get
        case .photo( _):
            return .get
        }
    }
    
    var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .photo, .random:
            return ["": ""]
        }
    }
}

