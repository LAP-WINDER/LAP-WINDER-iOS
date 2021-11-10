//
//  LoginVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/09.
//
// 1. Color pink RGB: (251,163,216)
// UIColor(displayP3Red: 251/255, green: 163/255, blue: 216/255, alpha: 1.0)
// 2. Color purple RGB: (93,76,201)
// UIColor(displayP3Red: 93/255, green: 76/255, blue: 201/255, alpha: 1.0)
// 3. 버튼 회색
// UIColor(displayP3Red: 240/255, green: 243/255, blue: 244/255, alpha: 0.4)
// 4. 진한 남색 포인트 컬러
// UIColor(displayP3Red: 1/255, green: 4/255, blue: 48/255, alpha: 0.8)

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cancelBtn: UIImageView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var kakaoLoginBtn: UIImageView!
    @IBOutlet weak var naverLoginBtn: UIImageView!
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapSignUpBtn(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        self.backgroundView.backgroundColor = UIColor(displayP3Red: 93/255, green: 76/255, blue: 201/255, alpha: 1.0)
        self.cancelBtn.tintColor = UIColor(displayP3Red: 251/255, green: 163/255, blue: 216/255, alpha: 1.0)
        self.loginBtn.backgroundColor = UIColor(displayP3Red: 240/255, green: 243/255, blue: 244/255, alpha: 0.4)
        self.loginBtn.layer.cornerRadius = 10
        self.loginBtn.tintColor = .white
        
        self.signUpBtn.backgroundColor = UIColor(displayP3Red: 251/255, green: 163/255, blue: 216/255, alpha: 1.0)
        self.signUpBtn.tintColor = .white
        self.signUpBtn.layer.cornerRadius = 10
//        self.kakaoLoginBtn.image = UIImage(named: "kakao_login_large_wide")
//        self.naverLoginBtn.image = UIImage(named: "naver_login_large_wide")
        
        
        //        self.loginView.alpha = 0.7
        //        self.loginView.layer.cornerRadius = 25
        //        self.loginView.clipsToBounds = true
        //
        //        self.cancelBtn.alpha = 0.7
        //        self.cancelBtn.layer.cornerRadius = 12
        //        self.cancelBtn.clipsToBounds = true
        //        self.cancelBtn.backgroundColor = .white
    }
}
