//
//  SectionView.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/04.
//

import UIKit
import SnapKit

final class SectionView : UIView {
    
    private var sectionText:String!
    
    //UIImageView
    private lazy var locationImage: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "section")
        return imageView
    }()
    //Label
    private lazy var label: UILabel = {
       let label = UILabel()
        label.text = sectionText
        return label
    }()
    
    init(text: String) {
        
        super.init(frame: .zero)
        self.sectionText = text
        
        addSubview(locationImage)
        locationImage.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(20)
            
        }
        
        addSubview(label)
        label.snp.makeConstraints{
            $0.top.equalTo(locationImage.snp.top)
            $0.leading.equalTo(locationImage.snp.trailing)
            $0.bottom.equalTo(locationImage.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    
    
    
    
}
