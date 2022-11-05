//
//  ImageSliderView.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/05.
//

import UIKit
import RxSwift

final class ImageListView:UIView {
   
    
    private let currentBannerPage = PublishSubject<Int>()
    private let disposeBag = DisposeBag()
    var imageList:[String]!
    //MARK: 치수 세팅
    private enum Const {
        static let imageHeight = 300
        static let itemSize = CGSize(width: UIScreen.main.bounds.width-60, height: 300)
        static let itemSpacing = 24.0
        
        static var insetX: CGFloat {
            (UIScreen.main.bounds.width-60 - Self.itemSize.width) / 2.0
        }
        static var collectionViewContentInset: UIEdgeInsets {
            UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
        }
    }
    
    //MARK: 콜랙션 뷰 레이아웃
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Const.itemSize // <-
        layout.minimumLineSpacing = Const.itemSpacing // <-
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    //MARK: CollectionView Layout 가져오기
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ -> NSCollectionLayoutSection? in
            let screenWidth = UIScreen.main.bounds.width
            let estimatedHeight = NSCollectionLayoutDimension.estimated(screenWidth)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: estimatedHeight)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: estimatedHeight)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered
            //Scroll 핸들러
            section.visibleItemsInvalidationHandler = { [weak self] _, contentOffset, environment in
                let bannerIndex = Int(max(0, round(contentOffset.x / environment.container.contentSize.width)))
                //self?.pageControl.currentPage = bannerIndex
                self?.currentBannerPage.onNext(bannerIndex)
            }
            
            return section
        }
        return layout
    }
    //MARK: 콜랙션 뷰
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.85).isActive = true
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(SliderCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: SliderCollectionViewCell.self))
        collectionView.collectionViewLayout = createCollectionViewLayout()
        return collectionView
    }()
    
    //MARK: pageController
    lazy var pageControl: UIPageControl = {
        
        let pageControl = UIPageControl()
        pageControl.backgroundColor = UIColor.clear
        
        // Set the number of pages to page control.
        pageControl.numberOfPages = imageList.count
        pageControl.pageIndicatorTintColor = .blue
        
        // Set the current page.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    
    init(imgList: [String]) {
        super.init(frame: .zero)
        
        self.imageList = imgList
        //MARK: BIND
        self.currentBannerPage.asObservable()
            .subscribe(onNext: { [weak self] currentPage in
                
                self?.pageControl.currentPage = currentPage
            })
            .disposed(by: disposeBag)
        
        
        
        addSubview(collectionView)
        addSubview(pageControl)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        pageControl.snp.makeConstraints{
            $0.height.equalTo(40)
            $0.bottom.equalTo(collectionView.snp.bottom).offset(-5)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK: UICollection DataSource
extension  ImageListView: UICollectionViewDelegate, UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    //이미지 리스트 변환
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //페이징 기능
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
        //targetContentOffset.pointee = CGPoint(x: index * cellWidth , y: scrollView.contentInset.top)
        //페이지 컨트롤러 점 변경
        Logger().Log_Y("======START======")
        let page = Int(targetContentOffset.pointee.x / collectionView.frame.width)
        self.pageControl.currentPage = page
    }

    //콜렉션뷰 셀 설정
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imgString = imageList[indexPath.row]
        //Logger().Log_Y("imgString:\(imgString)")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as? SliderCollectionViewCell else { return UICollectionViewCell() }
        
        
        guard let url = URL(string: imgString) else {return UICollectionViewCell() }
        cell.imageView.kf.setImage(with: url)
        return cell
    }

}
