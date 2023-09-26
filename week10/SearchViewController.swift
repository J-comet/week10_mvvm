//
//  SearchViewController.swift
//  week10
//
//  Created by 장혜성 on 2023/09/21.
//

import UIKit
import SnapKit

// 커스텀셀 모던 컬렉션뷰
final class SearchViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionFlowLayout())
    let list = Array(0...100)
    
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureDataSource()
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // cell 사이즈가 자유로울 떄 (언스플래시 앱, 모아앱)
    // 섹션마다 다르게
    func collectionFlowLayout() -> UICollectionViewLayout {
        
        // 아이템 몇개씩 나타낼지
        let count = 3
        
        // 현재 itemSize
        // widthDimension = group width 의 1/3
        // heightDimension = group 의 높이로 설정 = (80)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/CGFloat(count)), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // group item 바구니
        // 현재 gropSize
        // widthDimension = 컬렉션뷰 width 꽉 채우도록
        // heightDimension = 80
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: count)
        group.interItemSpacing = .fixed(10) // 아이템간의 간격
                
        // 컬렉션뷰 contentInsets - Margin 설정
        let section = NSCollectionLayoutSection(group: group)
        // layout.sectionInset == 기존의 UICollectionViewFlowLayout 과 동일
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 20  // 그룹간의 간격 (현재 가로기준으로 그룹이 묶여있음 NSCollectionLayoutGroup.horizotal)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
//    func collectionFlowLayout() -> UICollectionViewFlowLayout {
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 50, height: 50)
//        layout.scrollDirection = .vertical
//        return layout
//    }
    
    // UICollectionViewDiffableDataSource 상속받은 SubClass 에서 모두 처리하도록?
    func configureDataSource() {
        let cellRegistraion = UICollectionView.CellRegistration<SearchCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            cell.configure()
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(itemIdentifier) 번"
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistraion, for: indexPath, item: itemIdentifier)
        })
        
        // dataSource 와 같은 타입 -> UICollectionViewDiffableDataSource<Int, Int>!
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
        snapshot.appendItems(list, toSection: 0)
        dataSource.apply(snapshot)
    }
    
    // delegate 방식
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
//        cell.label.text = "\(list[indexPath.item]) 번"
//        return cell
//    }
}

// 세로 스크롤뷰 + UIView
//final class SearchViewController: UIViewController, UIScrollViewDelegate {
//    
//    private let scrollView = UIScrollView()
//    private let contentView = UIView()
//    
//    private let imageView = UIImageView(frame: .zero)
//    private let label = UILabel()
//    private let button = UIButton()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureHierarchy()
//        configureLayout()
//        configureContentView()
//    }
//    
//    // 스크롤 높이 확인용
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset)
//        print(scrollView.contentOffset.y)
//        
//        // ex
//        if scrollView.contentOffset.y >= 50 {
//            label.alpha = 0
//        } else {
//            label.alpha = 1
//        }
//    }
//    
//    
//    private func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//    }
//    
//    private func configureContentView() {
//        scrollView.delegate = self
//        imageView.backgroundColor = .brown
//        button.backgroundColor = .systemMint
//        label.backgroundColor = .green
//        contentView.addSubview(imageView)
//        contentView.addSubview(button)
//        contentView.addSubview(label)
//        
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView).inset(18)
//            make.height.equalTo(200)
//        }
//        
//        button.snp.makeConstraints { make in
//            make.bottom.horizontalEdges.equalTo(contentView).inset(10)
//            make.height.equalTo(80)
//        }
//        
//        label.text = "오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉오이이이잉\n오이이이잉\n오이이이잉오이이이잉오이이이잉오이이이잉"
//        label.textColor = .white
//        label.numberOfLines = 0
//        label.snp.makeConstraints { make in
//            make.horizontalEdges.equalTo(contentView)
//            make.top.equalTo(imageView.snp.bottom).offset(50)
//            make.bottom.equalTo(button.snp.top).offset(-50)
//        }
//    }
//    
//    private func configureLayout() {
//        scrollView.bounces = false  // 바운스효과 제거
//        scrollView.backgroundColor = .systemYellow
//        scrollView.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//        
//        contentView.backgroundColor = .white
//        contentView.snp.makeConstraints { make in
//            make.verticalEdges.equalTo(scrollView)
//            // width 로 스크롤뷰와 같다고 설정해주어야 꽉찬 width 가 생성됨
//            make.width.equalTo(scrollView.snp.width)
//        }
//        
//    }
//    
//}

// 가로 스크롤뷰 + 스택뷰
//final class SearchViewController: UIViewController {
//
//    private let scrollView = UIScrollView()
//    private let stackView = UIStackView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        configureHierarchy()
//        configureStackView()
//        configureLayout()
//    }
//
//    private func configureHierarchy() {
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//    }
//
//    private func configureLayout() {
//        scrollView.backgroundColor = .systemPink
//        scrollView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(70)
//        }
//
//        stackView.axis = .horizontal
//        stackView.spacing = 8
//
//        stackView.backgroundColor = .systemGreen
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(scrollView)
//            make.height.equalTo(70)
//        }
//    }
//
//    private func configureStackView() {
//        let label1 = UILabel()
//        label1.text = "안 1111111111111"
//        label1.textColor = .white
//        label1.backgroundColor = .orange
//        stackView.addArrangedSubview(label1)
//
//        let label2 = UILabel()
//        label2.text = "안녕 222222222"
//        label2.textColor = .white
//        label2.backgroundColor = .link
//        stackView.addArrangedSubview(label2)
//
//        let label3 = UILabel()
//        label3.text = "안녕하 333333333"
//        label3.textColor = .white
//        label3.backgroundColor = .link
//        stackView.addArrangedSubview(label3)
//
//        let label4 = UILabel()
//        label4.text = "안녕하세 444444444"
//        label4.textColor = .white
//        label4.backgroundColor = .link
//        stackView.addArrangedSubview(label4)
//
//        let label5 = UILabel()
//        label5.text = "안녕하세요 555555555"
//        label5.textColor = .white
//        label5.backgroundColor = .link
//        stackView.addArrangedSubview(label5)
//    }
//}
