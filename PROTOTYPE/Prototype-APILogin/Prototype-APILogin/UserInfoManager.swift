//
//  UserInfoManager.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/09.
//

import Foundation
import Alamofire

struct UserInfoKey {
    var loginEmail: String
    var loginName: String
    var loginProfile: String
}

class UserInfoManager {
    
    var userInfoKey = UserInfoKey(loginEmail: "test", loginName: "nickname", loginProfile: "image.png")
    
    func logout(completion: (() -> Void)? = nil) {
        //1. 호출 URL 문자열
        let url = "https://winder.info/api/v1/user/logout"
        
        //2. 인증헤더 구현
        let tk = SecurityUtils()
        let header = tk.getAuthorizationHeader()
        
        //3. API호출 및 응답 처리
        let call = AF.request(url,
                              method: .post,
                              parameters: nil,
                              encoding: JSONEncoding.default,
                              headers: header
        )
        call.responseJSON { _ in
            // 서버로 부터 전달받은 응답 처리
            self.deviceLogout()
            completion?()
        }
    }
    
    func deviceLogout() {
        // 기본저장소에 저장해둔 값 삭제
        let ud = UserDefaults.standard  // 저장소 객체 불러오기
        ud.removeObject(forKey: self.userInfoKey.loginEmail)
        ud.removeObject(forKey: self.userInfoKey.loginName)
        ud.removeObject(forKey: self.userInfoKey.loginProfile)
        ud.synchronize()        // 동기화 처리
        
        // 키체인에 저장된 값 삭제
        let tk = SecurityUtils()
        tk.delete("com.winder.Prototype-APILogin", account: "accessToken")
    }
}
