//
//  LoginVC.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/09.
//

import Foundation
import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

enum TokenType {
    case access
    case refresh
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapKakaoLoginBtn(_ sender: Any) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoAccount(prompts: [.Login]) { oauthToken, error in
                if let error = error {
                    print(#function, error.localizedDescription)
                } else if let oauthToken = oauthToken {
                    print("otoken: \(oauthToken)")
                    let tokenInfo = TokenInfo(accessToken: self.setTokenInfo(oauthToken, option: .access),
                                              refreshToken: self.setTokenInfo(oauthToken, option: .refresh),
                                              provider: "kakao"
                    )
                    MemberServiceAPIManager().pushTokenFromKakaoLogin(tokenInfo)
                    //self.checkUserInfoFromKakaoAPI()
                }
            }
        }
    }
    
    func setTokenInfo(_ oauthToken: OAuthToken, option: TokenType) -> TokenAndExpiredDict {
        var tokenDict: TokenAndExpiredDict
        if option == .access {
            tokenDict = [
                "token": "\(oauthToken.accessToken)",
                "expiredAt": "\(oauthToken.expiredAt)",
                "expiresIn": "\(oauthToken.expiresIn)",
            ]
        } else {
            tokenDict = [
                "token": "\(oauthToken.refreshToken)",
                "expiredAt": "\(oauthToken.refreshTokenExpiredAt)",
                "expiresIn": "\(oauthToken.refreshTokenExpiresIn)",
            ]
        }
        return tokenDict
    }
    
    @IBAction func checkUserInfoBtn(_ sender: Any) {
        self.checkUserInfoFromKakaoAPI()
    }
    func checkUserInfoFromKakaoAPI() {
        UserApi.shared.me { user, error in
            if let error = error {
                print(#function, error.localizedDescription)
            } else if let user = user {
                print(#function, user)
            }
        }
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        guard let preVC = self.presentingViewController as? MainTBC else {
            return
        }
        guard let profileVC = preVC.viewControllers?[2] as? ProfileVC else {
            return
        }
        if let email = self.emailTextField.text, let pwd = self.passwordTextField.text {
            MemberServiceAPIManager().isValidUser(User(email: email, password: pwd)) { tokenStr, error in
                if tokenStr != nil {
                    profileVC.paramEmail = email
                    SecurityUtils().save((Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String)!, account: email, value: tokenStr!)
                    print("tokenStr: \(tokenStr ?? "")")
                    self.dismiss(animated: true, completion: nil)
                } else if let error = error {
                    self.alert(error.localizedDescription, completion: nil)
                    print("Something wrong.")
                } else {
                    self.alert("로그인이 되지 않았습니다.", completion: nil)
                    print("Something wrong.")
                }
            }
        }
    }
    
    
    @IBAction func didTapCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSignUpBtn(_ sender: Any) {
        //
    }
    
    
}
