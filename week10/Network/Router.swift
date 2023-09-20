//
//  Router.swift
//  week10
//
//  Created by 장혜성 on 2023/09/20.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    private static let key = "v5xVYXamHA8lxYD692kNCwXiS5A7N3ZiYTe6UdDNL_Y"
    
    case search(query: String)
    case random
    case photo(id: String)  // 열거형 연관 값 -> associated value
    
    private var baseURL: URL {
        return URL(string: "https://api.unsplash.com/")!
    }
    
    private var path: String {
        switch self {
        case .search:
            return "search/photos"
        case .random:
            return "photos/random"
        case .photo(let id):
            return "photos/\(id)"
        }
    }
    
    private var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(Router.key)"]
    }
    
    private var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .random:
            return .get
        case .photo( _):
            return .get
        }
    }
    
    private var query: [String: String] {
        switch self {
        case .search(let query):
            return ["query": query]
        case .photo, .random:
            return ["": ""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.headers = header
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        return request
    }
    
    
}
