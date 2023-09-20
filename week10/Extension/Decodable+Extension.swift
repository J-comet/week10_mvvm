//
//  Decodable+Extension.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation

extension Data {
    func decodedObject<T: Decodable>(using decoder: JSONDecoder = .init()) throws -> T {
        try decoder.decode(T.self, from: self)
    }
}
