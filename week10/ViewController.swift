//
//  ViewController.swift
//  week10
//
//  Created by 장혜성 on 2023/09/19.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .yellow
        view.minimumZoomScale = 1
        view.maximumZoomScale = 4
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        return view
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureGesture()
        viewModel.request { [weak self] imgUrl in
            self?.imageView.kf.setImage(with: imgUrl)
        }
        
//        searchPhotos(query: "sky")
//        random()
//        detailPhoto(id: "EVtFPwebHOo")
        
        // 기존 방식대로 하면 옵셔널바인딩으로 옵셔널을 해제해줘야 함. -> Result Enum 으로 결과값 받도록 수정 필요
//        NetworkBasic.shared.random { photoResult, error in
//            // Result Enum 으로 개선된 코드보다 가독성이 안좋아보이고, 옵셔널바인딩을 해줘야된다.
//            if let error {
//                print(error)
//            } else {
//                guard let photoResult else { return }
//                print(photoResult)
//            }
//        }
//
//        // Result Enum 으로 개선된 코드
//        NetworkBasic.shared.detailPhoto(id: "EVtFPwebHOo") { response in
//            switch response {
//            case .success(let photoResult):
//                print(photoResult)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        NetworkBasic.shared.searchPhotos(query: "sky") { response in
//
//        }
        
        
        
        // type 도 UnsplashAPI 에 연산프로퍼티로 사용가능하지 않을까
//        Network.shared.request(api: .search(query: "sky"), type: Photo.self) { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//        
//        Network.shared.request(api: .random, type: PhotoResult.self) { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//        
//        Network.shared.request(api: .photo(id: "EVtFPwebHOo"), type: PhotoResult.self) { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(400)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
    }
    
    private func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    private func configureGesture() {
        // 두번탭 했을 때 동작할 제스쳐
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapTesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapTesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(2, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
   
}

extension ViewController: UIScrollViewDelegate {
    
    // zoom 기능
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

// Codable : Decodable + Encodable
struct Photo: Decodable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}
