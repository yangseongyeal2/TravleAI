//
//  SliderCollectionViewCell.swift
//  ExPhotoSlider
//
//  Created by Jake.K on 2021/12/14.
//

import UIKit
import SnapKit

final class SliderCollectionViewCell: UICollectionViewCell {
  // MARK: UI
    let imageView = UIImageView()
    override func layoutSubviews() {
        contentView.addSubview(imageView)

        imageView.contentMode = .scaleAspectFit
        //imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints {
            $0.width.top.leading.trailing.equalToSuperview()
        }

    }
}


