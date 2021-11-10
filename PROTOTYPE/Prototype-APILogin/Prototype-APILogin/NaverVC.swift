//
//  NaverVC.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/08.
//

import Foundation
import NaverThirdPartyLogin
import UIKit
import Alamofire

class NaverVC: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    
    let naverLoginURL: Dictionary<String, String> = [
        "authorize": "https://nid.naver.com/oauth2.0/authorize",
        "tokenhandler": "https://nid.naver.com/oauth2.0/token",
        "accessprofile": "https://openapi.naver.com/v1/nid/me"
    ]
    
    // 인스턴스 생성
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
    }
    
    func setUpInitialView() {
        //델리게이트로  지정
        self.naverLoginInstance?.delegate = self
    }
    
    @IBAction func didTapNaverLoginBtn(_ sender: Any) {
        self.naverLoginInstance?.requestThirdPartyLogin()
    }
    
    private func getLoginInfoFromNaverDelegate() {
        print("here?1")
        guard let isValidAccessToken = self.naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return
        }
        
        if !isValidAccessToken { return }
        print("here?2")
        guard let tokenType = self.naverLoginInstance?.tokenType else { return }
        guard let accessToken = self.naverLoginInstance?.accessToken else { return }
        let urlStr = self.naverLoginURL["accessprofile"]
        let url = URL(string: urlStr!)!
        let authorization = "\(tokenType) \(accessToken)"
        print("here: \(authorization)")
        
        let req = AF.request(url,
                             method: .get,
                             parameters: nil,
                             encoding: JSONEncoding.default,
                             headers: ["Authorization": authorization]
        )
    
        req.responseJSON { response in
            print("JSON=\(try! response.result.get())")
//            if let jsonObject = try! response.result.get() as? [String: Any] {
//                self.nameLabel.text = jsonObject["nickname"] as? String
//                self.emailLabel.text = jsonObject["email"] as? String
//                print("JsonObj, \(jsonObject)")
//            }
            
            //self.nicknameLabel.text = "\(nickname)"
        }
        
    }
    
    //do something
    
}

// MARK: -- 네이버 로그인관련 델리게이트 구현
extension NaverVC: NaverThirdPartyLoginConnectionDelegate {
    
    // 로그인 성공했을 때 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Success] : Success Naver Login")
        getLoginInfoFromNaverDelegate()
    }
    
    // 접근할 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        //
    }
    
    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        self.naverLoginInstance?.requestDeleteToken()
    }
    
    // 모든 Error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Error] :", error.localizedDescription)
    }
    
    
}
