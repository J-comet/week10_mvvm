//
//  BearViewModel.swift
//  week10
//
//  Created by 장혜성 on 2023/09/20.
//

import Foundation

final class BearViewModel {
    
    var imgURL: Observable<URL?> = Observable(nil)
    
    func requestRandom() {
        NetworkBear.shared.requestConvertible(api: .random, type: [BearInfo].self) { response in
            switch response {
            case .success(let success):
                print(success)
                self.imgURL.value = URL(string: success.first?.imageURL ?? "")
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
