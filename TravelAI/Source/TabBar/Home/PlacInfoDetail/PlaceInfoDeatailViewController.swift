//
//  PlaceInfoDeatailViewController.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/03.
//

import UIKit
import Kingfisher
import SnapKit

final class PlaceInfoDeatailViewController : UIViewController {
    
    private var placeInfo:PlaceInfo!
    
    private lazy var mainImageView:UIImageView = {
        let imageView = UIImageView()
        let url = URL(string: placeInfo.MainImage)
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func viewDidLoad() {
        Logger().Log_Y("viewDiDLoad")
        self.view.addSubview(mainImageView)
        mainImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(300)
            
        }
    }
    
    init(placeInfo: PlaceInfo) {
        super.init(nibName: nil, bundle: nil)

        self.placeInfo = placeInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  

    
    
}
