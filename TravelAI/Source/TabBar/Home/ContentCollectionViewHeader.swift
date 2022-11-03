//
//  ContentCollectionViewHeader.swift
//  NetflixStyleCollectionViewSampleApp
//
//  Created by Bo-Young PARK on 2021/07/27.
//

import UIKit

class ContentCollectionViewHeader: UICollectionReusableView {
    let sectionNameLabel = UILabel()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .black
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        sectionNameLabel.snp.makeConstraints {
            
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
        }
    }
}
