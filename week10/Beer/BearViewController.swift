//
//  BearViewController.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import UIKit
import Alamofire

class BearViewController: UIViewController {
    
    let baseURL = "https://api.punkapi.com/v2/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkBear.shared.request(api: .getBears(request: RequestBears(page: 1, per_page: 20)), type: [BearInfo].self) { response in
            switch response {
            case .success(let success):
//                print(success)
                var result = success[0]
                self.printAddress(address: &result)
                print("=============================")
                
                // 값 복사 1번 - CopyProtocol
                var newItem = result.copy { bearInfo in
                    bearInfo.name = "새 아이템"
                }
                print(newItem)
                self.printAddress(address: &newItem)
                print("=============================")
                
                // 값 복사 2번 - copy<T>()
                var secondItem = self.copy(result) { $0.name = "두번째 아이템" }
                print(secondItem)
                self.printAddress(address: &secondItem)
                print("=============================")
                
                // 값 복사 3번 - CopyStruct
                var thirdItem = Copy(result)
                thirdItem.value.name = "3번째 아이템"
                print(thirdItem.value)
                self.printAddress(address: &thirdItem)
                print("=============================")
                
                
            case .failure(let failure):
                print(failure)
            }
        }
        
//        NetworkBear.shared.request(api: .getDetailBear(id: 1), type: [BearInfo].self) { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
//        NetworkBear.shared.request(api: .random, type: [BearInfo].self) { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
    }
    
    // copy 함수
    func copy<T>(_ src: T, block: (inout T) -> ()) -> T {
        var dest = src
        block(&dest)
        return dest
    }

    // 주소값 확인
    func printAddress(address o: UnsafeRawPointer) {
            print(String(format: "%p", Int(bitPattern: o)))
     }
}
