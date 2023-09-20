//
//  Bears.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation

struct BearInfo: Decodable, CopyProtocol {
    var id: Int
    var name: String
    var description: String
    var imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
    }
}
