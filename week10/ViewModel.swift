//
//  ViewModel.swift
//  week10
//
//  Created by 장혜성 on 2023/09/20.
//

import Foundation

final class ViewModel {
    
    
    func request(completion: @escaping (URL?) -> Void) {
        // Router 로 호출
        Network.shared.requestConvertible(api: .random, type: PhotoResult.self) { response in
            switch response {
            case .success(let success):
                print(success)
                completion(URL(string: success.urls.thumb)!)
            case .failure(let failure):
                print(failure.errorDescription)
                completion(nil)
            }
        }
    }
    
}
