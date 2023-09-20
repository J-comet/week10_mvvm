//
//  BearAPI.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation
import Alamofire

enum BearAPI {
    
    case getBears(request: RequestBears)
    case getDetailBear(id: Int)
    case random
    
    private var baseURL: String {
        return "https://api.punkapi.com/v2/"
    }
    
    var endpoint: URL {
        switch self {
        case .getBears:
            return URL(string: baseURL + "beers")!
        case .getDetailBear(let id):
            return URL(string: baseURL + "beers/\(id)")!
        case .random:
            return URL(string: baseURL + "beers/random")!
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getBears( _):
            return .get
        case .getDetailBear( _):
            return .get
        case .random:
            return .get
        }
    }
    
    var query: [String: Any] {
        switch self {
        case .getBears(let request):
            return request.parameters
//            [
//                "page" : String(page),
//                "per_page" : "20"
//            ]
        case .getDetailBear( _), .random:
            return ["": ""]
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getBears( _):
            return URLEncoding(destination: .queryString)
        case .getDetailBear( _):
            return URLEncoding(destination: .queryString)
        case .random:
            return URLEncoding.default
        }
    }
}
