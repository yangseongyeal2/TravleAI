//
//  PlaceInfoCollectionViewCell.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/03.
//

import UIKit

class PlaceInfoCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    
    override func layoutSubviews() {
        contentView.addSubview(imageView)
//        contentView.snp.makeConstraints {
////            $0.topMargin.eq
////            $0.height.equalTo(imageView.snp.width)
//        }
        //imageView
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
    }
}
