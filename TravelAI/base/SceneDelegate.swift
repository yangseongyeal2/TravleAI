//
//  SceneDelegate.swift
//  Tweet
//
//  Created by Eunyeong Kim on 2021/08/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let rootViewModel = MainViewModel()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
                    guard let windowScene = (scene as? UIWindowScene) else { return }
                    window = UIWindow(windowScene: windowScene)
                    window?.backgroundColor = .systemBackground
                    window?.rootViewController = LoginViewController()
                    window?.makeKeyAndVisible()
//        if false {

//        }
//        else{
//
//            guard let windowScene = (scene as? UIWindowScene) else { return }
//            self.window = UIWindow(windowScene: windowScene)
//            let rootViewController = MainViewController()
//
//            rootViewController.bind(rootViewModel)
//            let rootNavigationController = UINavigationController(rootViewController: rootViewController)
//            window?.rootViewController = rootNavigationController
//            window?.makeKeyAndVisible()
//        }
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        self.window = UIWindow(windowScene: windowScene)
//        let rootViewController = MainViewController()
//
//        rootViewController.bind(rootViewModel)
//        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
//        window?.rootViewController = rootNavigationController
//        window?.makeKeyAndVisible()
    
    
    }

}

