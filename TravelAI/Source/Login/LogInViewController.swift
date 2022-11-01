//
//  LogInViewController.swift
//  TravelAI
//
//  Created by mobile_ on 2022/10/30.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import AuthenticationServices
import SnapKit
import CryptoKit
import FirebaseAuth
import RxFirebase

final class LoginViewController: UIViewController{
    
    let appleLoginButton = ASAuthorizationAppleIDButton()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setLayOut()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        //MARK: 버튼 클릭 이벤트 등록
        appleLoginButton.rx
            .loginOnTap(scope: [.fullName, .email])
            .subscribe(onNext: { result  in
                
                guard let appleIDCredential = result.credential as? ASAuthorizationAppleIDCredential else { return }
                print(appleIDCredential.user)
                print(appleIDCredential.email ?? "")
                print(appleIDCredential.fullName?.givenName ?? "")
                print(appleIDCredential.fullName?.familyName ?? "")
                
                let nonce = "1234"
                //                guard let nonce = self.currentNonce else {
                //                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                //                    }
                guard let appleIDToken = appleIDCredential.identityToken else {
                    print("Unable to fetch identity token")
                    return
                }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                    print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                    return
                }
                let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                          idToken: idTokenString,
                                                          rawNonce: nonce)
                let fb_auth = Auth.auth()
                // Sign in a user with an email address and password
                fb_auth.rx.signInAndRetrieveData(with: credential)
                    .subscribe(onNext: { authResult in
                        // User signed in
                        Logger().Log_Y("\(authResult)")
                        self.moveToMainPage()
                    }, onError: { error in
                        // Uh-oh, an error occurred!
                        Logger().Log_Y("\(error.localizedDescription)")
                    }).disposed(by: self.disposeBag)
            })
            .disposed(by: disposeBag)
    }


}

private extension LoginViewController {

    
    func setLayOut() {
        
        self.view.addSubview(appleLoginButton)
        
        appleLoginButton.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(300)
            $0.height.equalTo(50)
        }
    }
    func alertMSG(msg:String?){
        let sheet = UIAlertController(title: "알람", message: msg, preferredStyle: .alert)

        sheet.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { _ in print("yes 클릭") }))

        

        present(sheet, animated: true)
    }
    
    func moveToMainPage(){
        let tabBarController: TabBarViewController = TabBarViewController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
   
    
}


