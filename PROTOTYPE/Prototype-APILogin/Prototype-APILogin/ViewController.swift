//
//  ViewController.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/08.
//
// 사용자 인증 및 토큰발행, 토큰 존재여부 확인, 로그아웃, 토큰 정보 보기, 사용자 정보 보기

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapKakaoLoginBtn(_ sender: Any) {
        //카카오톡으로 로그인
        if UserApi.isKakaoTalkLoginAvailable() {
            //(prompts:[.Login]) -> 재인증 요청 시 활용
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                //
                if let error = error {
                    NSLog(error.localizedDescription)
                } else {
                    print("loginWithKakaoAccount() success.")
                    print("Token is: \(oauthToken)")
                    //do something
                    _ = oauthToken
                }
            }
        }
    }
    
    @IBAction func didTapTokenExistsBtn(_ sender: Any) {
        UserApi.shared.accessTokenInfo { (accessTokenInfo, error) in
            if let error = error {
                    print(error)
            } else {
                print("accessTokenInfo() success.")
                //do something
                print("accessTokenInfo(): \(accessTokenInfo)")
                _ = accessTokenInfo
            }
        }
    }
    
    @IBAction func didTapUserInfoBtn(_ sender: Any) {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("me() success.")
                print("me(): \(user)")
                //do something
                _ = user
            }
        }
    }
    

}

