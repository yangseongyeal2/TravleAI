//
//  SceneDelegate.swift
//  Tweet
//
//  Created by Eunyeong Kim on 2021/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        //window?.rootViewController = TabBarViewController()
//        let rootViewController = LoginViewController()
//        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
        
        window?.rootViewController = LoginViewController()
        //window?.rootViewController = rootNavigationController
        
        window?.makeKeyAndVisible()
    }

}

