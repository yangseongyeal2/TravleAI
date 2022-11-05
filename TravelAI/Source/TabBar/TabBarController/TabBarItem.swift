//
//  TabBarItem.swift
//  Tweet
//
//  Created by Eunyeong Kim on 2021/08/24.
//

import UIKit

enum TabBarItem: CaseIterable {
   
    case main
    case feed
    case profile

    var title: String {
        switch self {
        case .main: return "Main"
        case .feed: return "Feed"
        case .profile: return "Profile"
        }
    }

    var icon: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .main:
            return (UIImage(systemName: "house"), UIImage(systemName: "house.fill"))
        case .feed:
            return (UIImage(systemName: "list.bullet"), UIImage(systemName: "list.bullet"))
        case .profile:
            return (UIImage(systemName: "person"), UIImage(systemName: "person.fill"))
        }
    }
  

    var viewController: UIViewController {
        
        
        switch self {
        case .main:
            let imageHeight = 300
            let itemSize = CGSize(width: UIScreen.main.bounds.width-60, height: 300)
            let itemSpacing = 24.0
             
             
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.itemSize = itemSize // <-
           layout.minimumLineSpacing = itemSpacing // <-
           layout.minimumInteritemSpacing = 0
            
            let homeViewController = HomeViewController(collectionViewLayout: layout)
            //let homeViewController = HomeViewController()
            let rootNavigationController = UINavigationController(rootViewController: homeViewController)
            
            return rootNavigationController
        case .feed:
            return UINavigationController(rootViewController: ViewController())
        case .profile:
            return UINavigationController(rootViewController: ViewController())
        }
    }
}
