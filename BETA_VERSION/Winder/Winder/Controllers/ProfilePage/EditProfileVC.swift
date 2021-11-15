//
//  EditProfileVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/15.
//

import Foundation
import UIKit
import KakaoSDKUser

class EditProfileVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLogoutBtn(_ sender: Any) {
        
        if let userInfo = MemberInfoManager().loadProfile() {
            //카카오일 때 삭제방법
            if userInfo.provider == "kakao" {
                UserApi.shared.logout { error in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("logout() success.")
                    }
                }
            }
        }
        
        // 유저디폴트저장된거 삭제
        MemberInfoManager().deviceLogout()
        
        // 키체인토큰 삭제
        if let _ = SecurityUtils().load(SecurityUtils().bundleName, account: "accessToken") {
            SecurityUtils().delete(SecurityUtils().bundleName, account: "accessToken")
        }
        if let _ = SecurityUtils().load(SecurityUtils().bundleName, account: "refreshToken") {
            SecurityUtils().delete(SecurityUtils().bundleName, account: "refreshToken")
        }
        
        // 프로필 페이지로 돌아가기
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let preVC = self.presentingViewController as? MainTBC else {
            return
        }
        guard let profileVC = preVC.viewControllers?[2] as? ProfileTVC else {
            return
        }
        profileVC.viewWillAppear(true)
    }
    
}
