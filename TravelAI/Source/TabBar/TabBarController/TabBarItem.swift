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
//            let navController = UINavigationController(rootViewController: HomeViewController())
//            navController.hidesBarsOnTap = false
//            //navigationController?.navigationItem.rightBarButtonItem?.image =
//            navController.navigationItem.rightBarButtonItem?.image = UIImage(systemName: "list.dash")
//            return navController
            return UINavigationController(rootViewController: HomeViewController())
        case .feed:
            return UINavigationController(rootViewController: SearchViewController())
        case .profile:
            return UINavigationController(rootViewController: ViewController())
        }
    }
}
