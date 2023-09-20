//
//  BearRouter.swift
//  week10
//
//  Created by 장혜성 on 2023/09/20.
//

import Foundation
import Alamofire

enum BearRouter: URLRequestConvertible {
    
    case getBears(request: RequestBears)
    case getDetailBear(id: Int)
    case random
    
    private var baseURL: URL {
        return URL(string: "https://api.punkapi.com/v2/")!
    }
    
    private var path: String {
        switch self {
        case .getBears:
            return "beers"
        case .getDetailBear(let id):
            return "beers/\(id)"
        case .random:
            return "beers/random"
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getBears( _):
            return .get
        case .getDetailBear( _):
            return .get
        case .random:
            return .get
        }
    }
    
    private var query: [String: String] {
        switch self {
        case .getBears(let request):
            return request.parameters
        case .getDetailBear( _), .random:
            return ["": ""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(query, into: request)
        return request
    }
    
    
}
