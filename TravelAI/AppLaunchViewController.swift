//
//  AppLaunchViewController.swift
//  TravelAI
//
//  Created by mobile_ on 2022/11/01.
//

import UIKit
import SnapKit
import FirebaseAuth

final class AppLaunchViewController : UIViewController{
    
    private lazy var imageView: UIImageView? = {
        
        return UIImageView(image: UIImage(systemName: "message"))
    }()
    
    override func viewDidLoad() {
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            Logger().Log_Y("\(String(describing: Auth.auth().currentUser))")
            moveToMainPage()
        } else {
            // No user is signed in.
            Logger().Log_Y("not Login")
            moveToLoginPage()
        }
    }
    func setLayout() {
        
        self.view.addSubview(imageView ?? UIImageView())
        
        imageView?.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
    func moveToLoginPage(){
        let loginViewController: LoginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    func moveToMainPage(){
        let tabBarController: TabBarViewController = TabBarViewController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
}


