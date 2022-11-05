//
//  ImageListView.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/04.
//

import UIKit

final class ImageListView : UICollectionView {
    var imgList:[String]!
    
        
    lazy var pageControl: UIPageControl = {
            // Create a UIPageControl.
//            let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY - 100, width: self.view.frame.maxX, height:50))
            let pageControl = UIPageControl()
            //pageControl.backgroundColor = UIColor.orange
            pageControl.backgroundColor = UIColor.white
            
            // Set the number of pages to page control.
        pageControl.numberOfPages = imgList.count
            pageControl.pageIndicatorTintColor = .blue
        //pageControl.pageIndicatorTintColor = .blue
            // Set the current page.
            pageControl.currentPage = 0
            pageControl.isUserInteractionEnabled = false
            
            return pageControl
        }()
        
//        lazy var scrollView: UIScrollView = {
//            // Create a UIScrollView.
//            let scrollView = UIScrollView(frame: self.frame)
//            //let scrollView = UIScrollView()
//
//            // Hide the vertical and horizontal indicators.
//            scrollView.showsHorizontalScrollIndicator = false;
//            scrollView.showsVerticalScrollIndicator = false
//
//            // Allow paging.
//            scrollView.isPagingEnabled = true
//
//            // Set delegate of ScrollView.
//            scrollView.delegate = self
//
//            // Specify the screen size of the scroll.
//            //scrollView.contentSize = CGSize(width: CGFloat(pageSize) * self.frame.maxX, height: 0)
//
//            return scrollView
//        }()
    init(collectionView: UICollectionView, frame: CGRect) {
        //self.collectionView = collectionView
        //Setup collectionView layout here and pass with init
       // let layout = UICollectionViewLayout()
        super.init(frame: frame, collectionViewLayout: layout())
        collectionView.snp.makeConstraints{
            $0.leading.bottom.right.equalToSuperview()
            $0.top.equalToSuperview()
        }
        //MARK: 네비게이션 설정
        
        collectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: "SliderCollectionViewCell")
       
        collectionView.collectionViewLayout = self.layout()
        
        
        
        
        Logger().Log_Y("\(imgList)")
        // Get the vertical and horizontal sizes of the view.
        //let width = self.frame.maxX, height = self.frame.maxY
        
        
//        let width = scrollView.frame.maxX, height = self.frame.maxY
//        Logger().Log_Y("width:\(width)  height:\(height)")
//        // Generate buttons for the number of pages.
//
//
//        // Add UIScrollView, UIPageControl on view
//        addSubview(self.scrollView)
//        addSubview(self.pageControl)
//        scrollView.snp.makeConstraints{
//            $0.trailing.leading.top.equalToSuperview()
//            $0.height.equalTo(250)
//        }
//        pageControl.snp.makeConstraints{
//            $0.top.equalTo(scrollView.snp.bottom)
//            $0.trailing.equalTo(scrollView.snp.trailing)
//            $0.leading.equalTo(scrollView.snp.leading)
//            $0.height.equalTo(40)
//        }
        
    }
    
    private func layout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {[weak self] sectionNumber, environment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
//            switch self.contents[sectionNumber].sectionType {
//            case .basic:
//                return self.createBasicTypeSection()
//            case .main:
//                return self.createMainTypeSection()
//            case .large:
//                return self.createLargeTypeSection()
//            case .rank:
//                return  self.createRankTypeSection()
//            }
            return  self.createTravelInfoSection()
        }
    }
    
    
//    init(imgList: [String], frame) {
//
//        super.init(frame: frame, collectionViewLayout: layout)
//
//
//        super.init(frame: .zero)
//        // Do any additional setup after loading the view.
//
//
//
////        for i in imgList {
////                  // Generate different labels for each page.
////                 let imageView = UI
////
////                  scrollView.addSubview(label)
////              }
//
////        for i in 0 ..< pageSize {
////            // Generate different labels for each page.
////            let label: UILabel = UILabel()
////            label.backgroundColor = .red
////            label.textColor = .white
////            label.textAlignment = .center
////            label.layer.masksToBounds = true
////            label.text = "Page\(i)"
////
////            label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
////            label.layer.cornerRadius = 40.0
////
//////            label.snp.makeConstraints{
//////                $0.top.bottom.equalTo(scrollView)
//////                $0.leading.equalTo(scrollView)
//////            }
////
////            scrollView.addSubview(label)
////        }
////        let width2 = superview?.frame, height2 = superview?.frame
////        //let width = self.frame.maxX, height = self.frame.maxY
////        Logger().Log_Y("width2:\(String(describing: width2))  height2:\(String(describing: height2))")
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: TravelSectionLayout 설정
    private func createTravelInfoSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
        //secion
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
//        let sectionHeader = self.createSectionHeader()
//        section.boundarySupplementaryItems  = [sectionHeader]
//        section.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)
        
        return section
    }
}
