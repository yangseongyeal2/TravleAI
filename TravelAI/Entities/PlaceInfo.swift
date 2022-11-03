//
//  Content.swift
//  NetflixStyleCollectionViewSampleApp
//
//  Created by Bo-Young PARK on 2021/07/27.
//

import UIKit

struct PlaceInfo: Decodable {
    let MainImage: String
    let Section: String
    
    enum CodingKeys: String, CodingKey {
        case MainImage, Section
    }
}

