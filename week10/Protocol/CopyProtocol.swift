//
//  CopyProtocol.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation

protocol CopyProtocol {}
extension CopyProtocol {
    func copy(change: (inout Self) -> Void) -> Self {
        var a = self
        change(&a)
        return a
    }
}
