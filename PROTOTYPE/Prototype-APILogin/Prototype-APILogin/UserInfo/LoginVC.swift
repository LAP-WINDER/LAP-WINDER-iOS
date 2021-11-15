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

import NaverThirdPartyLogin


enum TokenType {
    case access
    case refresh
}

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //네이버 로그인 URL 정리
    let naverLoginURL: Dictionary<String, String> = [
        "authorize": "https://nid.naver.com/oauth2.0/authorize",
        "tokenhandler": "https://nid.naver.com/oauth2.0/token",
        "accessprofile": "https://openapi.naver.com/v1/nid/me"
    ]
    //네이버 로그인 인스턴스 생성
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaverLoginDelegate()
    }
    
    func setUpNaverLoginDelegate() {
        self.naverLoginInstance?.delegate = self
    }
    
    func getLoginInfoFromNaverDelegate() {
        guard let isValidAccessToken = self.naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return
        }
        if !isValidAccessToken { return }
        
        guard let refreshToken = self.naverLoginInstance?.refreshToken else { return }
        guard let accessToken = self.naverLoginInstance?.accessToken else { return }
        
        let tokenInfo = TokenInfo(accessToken: self.setNaverTokenInfo(accessToken),
                                  refreshToken: self.setNaverTokenInfo(refreshToken),
                                  provider: "naver"
        )
        
        MemberServiceAPIManager().pushTokenFromNaverLogin(tokenInfo)
    }

    func setNaverTokenInfo(_ token: String) -> TokenAndExpiredDict {
        let tokenDict: TokenAndExpiredDict = [
                "token": "\(token)",
                "expireAt": "",
                "expireIn": "",
        ]
        return tokenDict
    }
    
    // MARK: 네이버 로그인
    @IBAction func didTapNaverLoginBtn(_ sender: Any) {
        self.naverLoginInstance?.requestThirdPartyLogin()
    }
    
    // MARK: 카카오 로그인
    @IBAction func didTapKakaoLoginBtn(_ sender: Any) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoAccount(prompts: [.Login]) { oauthToken, error in
                if let error = error {
                    print(#function, error.localizedDescription)
                } else if let oauthToken = oauthToken {
                    print("otoken: \(oauthToken)")
                    let tokenInfo = TokenInfo(accessToken: self.setKakaoTokenInfo(oauthToken, option: .access),
                                              refreshToken: self.setKakaoTokenInfo(oauthToken, option: .refresh),
                                              provider: "kakao"
                    )
                    MemberServiceAPIManager().pushTokenFromKakaoLogin(tokenInfo)    //받아서 유저정보 저장까지
                    //self.checkUserInfoFromKakaoAPI()
                }
            }
        }
    }
    
    func setKakaoTokenInfo(_ oauthToken: OAuthToken, option: TokenType) -> TokenAndExpiredDict {
        var tokenDict: TokenAndExpiredDict
        if option == .access {
            tokenDict = [
                "token": "\(oauthToken.accessToken)",
                "expireAt": "\(oauthToken.expiredAt)",
                "expireIn": "\(oauthToken.expiresIn)",
            ]
        } else {
            tokenDict = [
                "token": "\(oauthToken.refreshToken)",
                "expireAt": "\(oauthToken.refreshTokenExpiredAt)",
                "expireIn": "\(oauthToken.refreshTokenExpiresIn)",
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

// MARK: -- 네이버 로그인관련 델리게이트 구현
extension LoginVC: NaverThirdPartyLoginConnectionDelegate {
    // 로그인 성공했을 때 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        getLoginInfoFromNaverDelegate()
    }
    
    // 접근할 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        //code
    }
    
    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        self.naverLoginInstance?.requestDeleteToken()
    }
    
    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Naver Login Error] :", error.localizedDescription)
    }
    
    
}
