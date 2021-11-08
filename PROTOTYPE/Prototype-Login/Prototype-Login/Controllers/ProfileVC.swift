//
//  ProfileVC.swift
//  Prototype-Login
//
//  Created by 이동규 on 2021/10/26.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    //
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    var paramEmail: String?
    var paramPassword: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ID-Action-toLoginVC" {
            if let lvc = self.storyboard?.instantiateViewController(withIdentifier: "ID-LoginVC") as? LoginVC {
                lvc.modalPresentationStyle = .fullScreen
                self.present(lvc, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        //1. 설치여부확인
        guard let session = KOSession.shared() else {
            return
        }
        if session.isOpen() {
            session.close()
        }
        session.open { error in
            if error != nil || !session.isOpen() { return }
            print("here1")
            
            KOSessionTask.userMeTask { error, user in
                if let error = error as NSError? {
                    UIAlertController.showMessage(error.description)
                } else if let me = user as KOUserMe? {
                    // 결과 보여주기
                    var message: String = ""
                    message.append("아이디: ")
                    message.append(me.id ?? "없음 (signup 필요함)")
                    if let account = me.account {
                        message.append("\n\n== 카카오계정 정보 ==")
                        
                        message.append("\n이메일: ")
                        if account.email != nil {
                            message.append(account.email!)
                        } else if account.emailNeedsAgreement == true {
                            message.append("있음 (사용자 동의가 필요함)")
                        } else {
                            message.append("없음")
                        }
                        
                        message.append("\n전화번호: ")
                        if account.phoneNumber != nil {
                            message.append(account.phoneNumber!)
                        } else if account.phoneNumberNeedsAgreement == true {
                            message.append("있음 (사용자 동의가 필요함)")
                        } else {
                            message.append("없음")
                        }
                        
                        message.append("\n출생 연도: ")
                        if account.birthday != nil {
                            message.append(account.birthyear!)
                        } else if account.birthyearNeedsAgreement == true {
                            message.append("있음 (사용자 동의가 필요함)")
                        } else {
                            message.append("없음")
                        }
                        
                        message.append("\n생일: ")
                        if account.birthday != nil {
                            message.append(account.birthday!)
                        } else if account.birthdayNeedsAgreement == true {
                            message.append("있음 (사용자 동의가 필요함)")
                        } else {
                            message.append("없음")
                        }
                        
                        if let properties = me.properties {
                            message.append("\n\n== 사용자 속성 ==\n\(properties.description)")
                        }
                        print("heere \(message)")
                    }
                }
            
                
                
//                print("here2")
//                guard let user = user,
//                      let email = user.account?.email,
//                      let nickname = user.nickname else { return }
//                print("login result! \(user)")
            }
        }
    }
    
    
    // 카카오 로그인 확인
    private let loginBtn: KOLoginButton = {
        let btn = KOLoginButton()
        btn.addTarget(self, action: #selector(kakaoLoginBtn(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    @objc private func kakaoLoginBtn(_ sender: UIButton) {
        //1. 설치여부확인
        guard let session = KOSession.shared() else {
            return
        }
        if session.isOpen() {
            session.close()
        }
        session.open { error in
            if error != nil || !session.isOpen() { return }
            print("here1")
            KOSessionTask.userMeTask { error, user in
                print("here2")
                guard let user = user,
                      let email = user.account?.email,
                      let nickname = user.nickname else { return }
                print("login result! \(user)")
            }
        }
        //1. 카카오api 호출 결과물 전달
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(#function) is called.")
        if let email = self.paramEmail {
            self.emailLabel.text = email
        }
        if let pwd = self.paramPassword {
            self.passwordLabel.text = pwd
        }
    }
    
}
