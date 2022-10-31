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

final class LoginViewController: UIViewController{
    
    let appleLoginButton = ASAuthorizationAppleIDButton()
    private let disposeBag = DisposeBag()
   
    private lazy var authorizationButton : ASAuthorizationAppleIDButton = {
        let authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
            authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        
        return authorizationButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        setLayOut()
        
        //Apple Login
//        appleLoginButton.rx
//            .loginOnTap(scope: [.fullName, .email])
//            .subscribe(onNext: { result in
//                guard let auth = result.credential as? ASAuthorizationAppleIDCredential else { return }
//                print(auth.user)
//                print(auth.email)
//                print(auth.fullName?.givenName)
//                print(auth.fullName?.familyName)
//            })
//            .disposed(by: disposeBag)
    }


}

private extension LoginViewController {
    @objc func handleAuthorizationAppleIDButtonPress () {
        print("button is inserted ")
        let appleIDProvider = ASAuthorizationAppleIDProvider()
         let request = appleIDProvider.createRequest()
         request.requestedScopes = [.fullName, .email]
             
         let authorizationController = ASAuthorizationController(authorizationRequests: [request])
         authorizationController.delegate = self
         authorizationController.presentationContextProvider = self
         authorizationController.performRequests()
    }
    
    func setLayOut() {
        
        self.view.addSubview(authorizationButton)
        
        authorizationButton.snp.makeConstraints{
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
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            Logger().Log_Y("TEST")
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            //self.alertMSG(msg: "로그인 성공")
            moveToMainPage()
        
            
        default:
            break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        alertMSG(msg: "로그인 실패")
    }
    
}

