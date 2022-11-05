//
//  PlaceInfoDeatailViewController.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/03.
//

import UIKit
import Kingfisher
import SnapKit
import TagListView
import SwiftUI
import Reusable
import RxSwift

final class PlaceInfoDeatailViewController : UIViewController {
    
    
    
    private var placeInfo:PlaceInfo!
    
   
    
    var imageList:[String] = []
    
    private let disposeBag = DisposeBag()
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
////    //MARK: 스코롤 뷰
    private lazy var scrollView : UIScrollView = {
        let frameSize = view.bounds.size
        let scrollView = UIScrollView(frame: CGRect(origin: CGPoint.zero, size: frameSize))
        //scrollView.backgroundColor = .systemGray
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //scrollView.direc
        return scrollView
    }()
    
    private lazy var imgListView : ImageListView = {
        let view = ImageListView(imgList: imageList)
    
        return view
    }()
     
    
     
    
    
    
    
    
    
    //MARK: SectionView
    private lazy var sectionView:SectionView = {
        let sectionView = SectionView(text: placeInfo.Section)
        return sectionView
    }()
    //MARK: TAGLISTVIEW
    //TagListView
    private lazy var tagListView:TagListView = {
        let tagListView = TagListView()
        tagListView.textFont = UIFont.systemFont(ofSize: 24)
        tagListView.alignment = .center // possible values are [.leading, .trailing, .left, .center, .right]
        tagListView.addTags(placeInfo.Tag)
        tagListView.tagBackgroundColor = .blue
        
        //Sample
        //tagListView.addTag("TagListView")
        //tagListView.addTags(["Add", "two", "tags"])
        //tagListView.insertTag("This should be the second tag", at: 1)
        //tagListView.setTitle("New Title", at: 6) // to replace the title a tag
        //tagListView.removeTag("meow") // all tags with title “meow” will be removed
        //tagListView.removeAllTags()
        
        return tagListView
    }()
    //MARK: 텍스트뷰 설명
    private lazy var textView:UITextView = {
        let textView = UITextView()
        
        textView.text = placeInfo.Descrypt
        // Round the corners.
        textView.layer.masksToBounds = true
        
        // Set the size of the roundness.
        textView.layer.cornerRadius = 20.0
        
        // Set the thickness of the border.
        textView.layer.borderWidth = 1
        
        // Set the border color to black.
        textView.layer.borderColor = UIColor.black.cgColor
        
        // Set the font.
        textView.font = UIFont.systemFont(ofSize: 20.0)
        
        // Set font color.
        textView.textColor = UIColor.black
        
        // Set left justified.
        textView.textAlignment = NSTextAlignment.left
        
        // Automatically detect links, dates, etc. and convert them to links.
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        
        // Set shadow darkness.
        textView.layer.shadowOpacity = 0.5
        
        // Make text uneditable.
        textView.isEditable = false
        
        textView.isScrollEnabled = false
        
        
        
        
        return textView
        
    }()
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        setLayout()
    }
    //MARK: SET PlaceInfo
    func setPlaceInfo(placeInfo: PlaceInfo){
        self.placeInfo = placeInfo
        imageList.append(placeInfo.MainImage)
        for i in placeInfo.SubImageList {
            imageList.append(i)
        }
    }

}

private extension PlaceInfoDeatailViewController {
    
    //MARK: 레이아웃 설정
    func setLayout(){
        
        //pageControl.numberOfPages = 0
      
      
        
        
        
        
        Logger().Log_Y("???")


        title = placeInfo.Title
        Logger().Log_Y("viewDiDLoad")
        
        
        self.view.addSubview(scrollView)

        scrollView.snp.makeConstraints {
            //존나 필수
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.top.equalToSuperview()
            $0.height.greaterThanOrEqualTo(view.snp.height).priority(.high)
            
            $0.width.equalTo(scrollView.snp.width)
        }

        scrollView.addSubview(imgListView)
        scrollView.addSubview(sectionView)
        scrollView.addSubview(tagListView)
        scrollView.addSubview(textView)
        

        
        //ImageListView
        imgListView.snp.makeConstraints{
            //$0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            //$0.bottom.equalToSuperview()
            $0.height.equalTo(Const.imageHeight)

        }

        //SectionView
        sectionView.snp.makeConstraints{
            $0.bottom.equalTo(imgListView.snp.bottom).offset(-30)
            $0.leading.equalTo(imgListView.snp.leading)
        }
        
        //TagListView
        tagListView.snp.makeConstraints{
            $0.top.equalTo(imgListView.snp.bottom).offset(10)
            $0.leading.equalTo(imgListView.snp.leading)
            $0.trailing.equalTo(imgListView.snp.trailing)
            
        }
        //TextView
        textView.snp.makeConstraints{
            $0.top.equalTo(tagListView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(imgListView)
            //$0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            //$0.height.equalTo(2000)
        }
    }
}


//MARK: 콜랙션뷰에서 스크롤 뷰 사용 하게 끔

private extension PlaceInfoDeatailViewController{
   
}

//SwiftUI를 활용한 미리보기
struct PlaceInfoDeatailViewController_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
           
            let placeInfo = PlaceInfo(Title: "경복궁", MainImage: "https://firebasestorage.googleapis.com/v0/b/travleai.appspot.com/o/images.jpeg?alt=media&token=0f394bbc-9a6d-4d33-9b2f-1f96947bb214", Section: "서울특별시", Descrypt: "경복궁은 대한민국 서울특별시 청와대로에 있는 조선 왕조의 법궁이다. 태조 4년인 1395년 창건되어 1592년 임진왜란으로 전소되었고, 1868년 흥선대원군의 주도로 중건되었다. 일제강점기에 훼손되어 현재 복원사업이 진행중이다. 《주례》 〈고공기〉에 입각하여 건축되었다.", SubImageList: ["https://firebasestorage.googleapis.com/v0/b/travleai.appspot.com/o/a9d13e1054ea6bb983c26964811d1e3914ae6b055e0288340b6a6e3c4eee28f9e2dad61f89a46af6ba5b83d8cb27cd045629f8335bbac9390b5d97260ddd08e1624179734067a23461f4ec9679f090cc7cfe38c9ed3d37adb361051317b23b22eadb456ce05fdcab4c26cd0efef62da2.jpeg?alt=media&token=5946d9ba-ad26-402c-aaab-1d4b28005243", "https://firebasestorage.googleapis.com/v0/b/travleai.appspot.com/o/images.jpeg?alt=media&token=0f394bbc-9a6d-4d33-9b2f-1f96947bb214"], Tag: ["#경복궁", "#서울여행"])
            
            
       
            let placeDetailViewController = PlaceInfoDeatailViewController()

            placeDetailViewController.setPlaceInfo(placeInfo:placeInfo)
            let rootNavigationController = UINavigationController(rootViewController: placeDetailViewController)

            return rootNavigationController
        }
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
        typealias UIViewControllerType = UIViewController
    }
    
   
}
