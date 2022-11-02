//
//  HomeViewController.swift
//  TravelAI
//
//  Created by mobile_ on 2022/10/30.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //        print("viewDidLoad")
        Logger().Log_Y("ViewDidLoad")
        
        self.title = "홈"
        self.view.backgroundColor = .systemTeal
        // 네비게이션 아이템 추가
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(goToProfileVC))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "message.fill"), style: .plain, target: self, action: #selector(goToMessageVC))
    }
    @objc func goToProfileVC(){
        
    }
    
    @objc func goToMessageVC(){
        
    }

}

