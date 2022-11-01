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
        //window?.rootViewController = LoginViewController()
        window?.rootViewController = AppLaunchViewController()
        
        window?.makeKeyAndVisible()
        
        
        
    }

}

