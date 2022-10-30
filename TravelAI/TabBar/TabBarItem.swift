//
//  TabBarItem.swift
//  Tweet
//
//  Created by Eunyeong Kim on 2021/08/24.
//

import UIKit

enum TabBarItem: CaseIterable {
    case feed
    case profile

    var title: String {
        switch self {
        case .feed: return "Feed"
        case .profile: return "Profile"
        }
    }

    var icon: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .feed:
            return (UIImage(systemName: "list.bullet"), UIImage(systemName: "list.bullet"))
        case .profile:
            return (UIImage(systemName: "person"), UIImage(systemName: "person.fill"))
        }
    }

    var viewController: UIViewController {
        switch self {
        case .feed:
            return UINavigationController(rootViewController: ViewController())
        case .profile:
            return UINavigationController(rootViewController: ViewController())
        }
    }
}
