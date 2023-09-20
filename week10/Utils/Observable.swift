//
//  Observable.swift
//  week10
//
//  Created by 장혜성 on 2023/09/20.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    // 값이 변경되었을 때 alert 을 띄우거나 변경내용을 레이블에 적용하거나 화면전환 or 네트워크 통신을 하고 싶다면?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        print(#function)
        closure(value)
        listener = closure
    }
}
