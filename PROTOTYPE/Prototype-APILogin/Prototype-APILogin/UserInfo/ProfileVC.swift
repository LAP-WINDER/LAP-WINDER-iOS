//
//  ProfileVC.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/09.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var mailnameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    var paramEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileView()
    }
    
    func setUpProfileView() {
        self.profileView.backgroundColor = UIColor(displayP3Red: 37/255, green: 47/255, blue: 122/255, alpha: 1.0)
        self.profileView.layer.cornerRadius = 25
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height / 2
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "ID-manual-to-LoginVC", sender: self)
    }
    
    @IBAction func didTapCheckTokenBtn(_ sender: Any) {
        if let email = self.paramEmail {
            let token = SecurityUtils().load("com.winder.Prototype-APILogin", account: email)
            print("token is saved: \(token)")
        }
    }
    
    @IBAction func didTapLogoutBtn(_ sender: Any) {
        //로그아웃: 토큰만료, 서버에 인증헤더 묶어서 포스트
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(#function) is called. Returned email: \(self.paramEmail)")
        DispatchQueue.main.async {
            if let email = self.paramEmail {
                self.mailnameLabel.text = "@\(email)"
            }
        }
    }
    
    @IBAction func unwindFromSignUpVC (segue : UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ID-manual-to-LoginVC" {
            if let loginvc = self.storyboard?.instantiateViewController(withIdentifier: "ID-LoginVC") as? LoginVC {
                loginvc.modalPresentationStyle = .fullScreen
                self.present(loginvc, animated: true, completion: nil)
            }
        }
        if segue.identifier == "ID-action-to-UserInfoVC" {
            //API 요청 미리할지 다음 뷰컨에서 뷰딛로에서 할지 결정
        }
    }
}
