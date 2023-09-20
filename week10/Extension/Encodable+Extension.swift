//
//  Encodable+Extension.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation

extension Encodable {
    
    var parameters : [String: Any] {
        guard let object = try? JSONEncoder().encode(self) else { return ["": ""] }
        guard let parameters = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { return ["": ""] }
        return parameters
    }
}
