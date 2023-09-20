//
//  CopyObj.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import Foundation

final class Ref<T> {
    var value: T
    init(_ v: T) { value = v }
}

struct Copy<T> {
    private var ref: Ref<T>
    init(_ obj: T) { ref = Ref(obj) }
    
    var value: T {
        get { return ref.value }
        set {
            if !isKnownUniquelyReferenced(&ref) {
                ref = Ref(newValue)
                return
            }
            ref.value = newValue
        }
    }
}
