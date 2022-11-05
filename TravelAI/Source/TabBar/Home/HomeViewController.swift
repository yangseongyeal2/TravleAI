//
//  HomeViewController.swift
//  TravelAI
//
//  Created by mobile_ on 2022/10/30.
//



import UIKit
import SwiftUI
import RxFirebase
import FirebaseFirestore
import RxSwift
import Kingfisher

class HomeViewController: UICollectionViewController {
    var placeInfos: [PlaceInfo] = []
    let disposeBag = DisposeBag()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayout()
        //TODO: ViewController 로 이동 해야함.
        getContents()
        Logger().Log_Y("placeInfos:\(placeInfos)")
    }
}
 
private extension HomeViewController {

     func setLayout() {
         Logger().Log_Y("ViewDidLoad")
         
         collectionView.snp.makeConstraints{
             $0.leading.bottom.right.equalToSuperview()
             $0.top.equalToSuperview().offset(150)
         }
         //MARK: 네비게이션 설정
         self.title = "홈"
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToMessageVC))
         //MARK: UICollectionView 설정
         collectionView.register(PlaceInfoCollectionViewCell.self, forCellWithReuseIdentifier: "PlaceInfoCollectionViewCell")
         collectionView.register(ContentCollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ContentCollectionViewHeader")
         collectionView.collectionViewLayout = layout()
         
         
         
    }
    //MARK: 버튼 클릭 이벤트
    @objc func goToProfileVC(){
        
    }
    
    @objc func goToMessageVC(){
        
    }
    func moveToDetailView(placeInfo:PlaceInfo){
        
        let layout = UICollectionViewFlowLayout()
        let placeDetailViewController = PlaceInfoDeatailViewController()
//        let placeDetailViewController = PlaceInfoDeatailViewController(collectionViewLayout: layout)
        placeDetailViewController.setPlaceInfo(placeInfo:placeInfo)
        navigationController?.pushViewController(placeDetailViewController, animated: true)
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
        //section.orthogonalScrollingBehavior = .continuous
        let sectionHeader = self.createSectionHeader()
        section.boundarySupplementaryItems  = [sectionHeader]
        section.contentInsets = .init(top: 0, leading: 30, bottom: 0, trailing: 30)
        
        return section
    }
    //MARK: SectionHeader layout 설정
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        //Section Header 사이즈
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        // Section Header Layout
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        return sectionHeader
    }
    //MARK: LAYOUT()
    ///각각의 섹션 타입에 대한 UICollectionViewLayout 생성
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
    //MARK: GET DATA
    func getContents() {
        
        //RXSWIFT Version
        //        db.collection("cities")
        //            .rx
        //            .getDocuments()
        //            .subscribe(onNext: { document in
        //                if let document = document {
        //                    print("Document data: \(document.data())")
        //                } else {
        //                    print("Document does not exist")
        //                }
        //            }, onError: { error in
        //                print("Error fetching snapshots: \(error)")
        //            }).disposed(by: disposeBag)
        
        //SWIFT Version
        db.collection("PlaceInfo")
            .getDocuments() {[weak self] (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        
                        guard let section = document.data()["Section"] as? String
                                , let mainImage = document.data()["MainImage"] as? String
                                , let descript = document.data()["Descrypt"] as? String
                                , let subImageList = document.data()["SubImageList"] as? [String]
                                , let tag = document.data()["Tag"] as? [String]
                                , let title = document.data()["Title"] as? String
                        else{
                            Logger().Log_Y("section or mainImage is null")
                            return
                        }
                        print("section:\(section)")
                        print("mainImage:\(mainImage)")
                        let placeInfo = PlaceInfo(Title:title,MainImage: mainImage, Section: section,Descrypt: descript,SubImageList: subImageList,Tag: tag)
                        //list.append(placeInfo)
                        self?.placeInfos.append(placeInfo)
                        self?.collectionView.reloadData()
                    }
                }
            }
        
    }


}
//MARK: FIREBASE get Documents
extension Reactive where Base: Query {
 
 // e.g.
public func getDocuments(source: FirestoreSource) -> Observable<QuerySnapshot> {
        return Observable<QuerySnapshot>.create { observer in
            self.base.getDocuments(source: source) { snapshot, error in
                if let error = error {
                    observer.onError(error)
                } else if let snapshot = snapshot {
                    observer.onNext(snapshot)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

//MARK: UICollectionView Datasource, Delegate
extension HomeViewController {
    //섹션당 보여질 셀의 개수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            //return 1
            return placeInfos.count
           // return 20
        default:
            //return contents[section].contentItem.count
            return 6
        }
    }
    
    //콜렉션뷰 셀 설정
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //A
//        switch contents[indexPath.section].sectionType {
//        case .basic, .large:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
//            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
//            return cell
//        case .main:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewMainCell", for: indexPath) as? ContentCollectionViewMainCell else { return UICollectionViewCell() }
//            cell.imageView.image = mainItem?.image
//            cell.descriptionLabel.text = mainItem?.description
//            return cell
//        case .rank:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewRankCell", for: indexPath) as? ContentCollectionViewRankCell else { return UICollectionViewCell() }
//            cell.imageView.image = contents[indexPath.section].contentItem[indexPath.row].image
//            cell.rankLabel.text = String(describing: indexPath.row + 1)
//            return cell
//        }
        
        let placeInfo = placeInfos[indexPath.row]
        Logger().Log_Y("placeInfo:\(placeInfo)")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceInfoCollectionViewCell", for: indexPath) as? PlaceInfoCollectionViewCell else { return UICollectionViewCell() }
        guard let url = URL(string: placeInfo.MainImage) else {return UICollectionViewCell() }
        cell.imageView.kf.setImage(with: url)
        return cell
    }
    
    //섹션 개수 설정
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        //return contents.count
        
        //Section 갯수
        return 1
    }
    
    //헤더뷰 설정
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ContentCollectionViewHeader", for: indexPath) as? ContentCollectionViewHeader else { fatalError("Could not dequeue Header") }
            
            //headerView.sectionNameLabel.text = contents[indexPath.section].sectionName
            headerView.sectionNameLabel.text = "여행지 정보"
            Logger().Log_Y("양성열 여행지 정보 return")
            return headerView
        } else {
            Logger().Log_Y("양성열 UICollectionReusableView return")
            return UICollectionReusableView()
        }
    }
    
    //셀 선택
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let sectionName = contents[indexPath.section].sectionName
        let sectionName = "TravelInfo"
        print("TEST: \(sectionName) 섹션의 \(indexPath.row + 1)번째 콘텐츠")
        moveToDetailView(placeInfo: placeInfos[indexPath.row])
        
    }
}

