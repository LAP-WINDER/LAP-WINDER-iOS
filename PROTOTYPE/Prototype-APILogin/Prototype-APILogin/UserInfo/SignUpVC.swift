//
//  SignUpVC.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/09.
//

import Foundation
import UIKit

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var inputEmailTextField: UITextField!
    @IBOutlet weak var validEmailTextField: UITextField! { didSet { validEmailTextField.delegate = self } }
    @IBOutlet weak var inputPwdTextField: UITextField! { didSet { inputPwdTextField.delegate = self } }
    @IBOutlet weak var validPwdTextField: UITextField! { didSet { validPwdTextField.delegate = self } }
    
    @IBOutlet weak var validEmailBtn: UIButton!
    @IBOutlet weak var validNumberBtn: UIButton!
    
    var validEmailNumber: String?
    var isValidEmail: Bool = false
    var isValidNumber: Bool = false
    
    @IBAction func didTapValidEmailBtn(_ sender: Any) {
        if let email = self.inputEmailTextField.text {
            MemberServiceAPIManager().isValidEmail(ValidEmail(email: email)) { validNumStr, error in
                if let validNumStr = validNumStr {
                    self.validEmailNumber = validNumStr
                    self.isValidEmail = true
                    print("valid number: \(self.validEmailNumber)")
                } else if let error = error {
                    self.alert(error.localizedDescription, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func didTapValidNumberBtn(_ sender: Any) {
        if let inputNumber = self.validEmailTextField.text {
            if let validNumber = self.validEmailNumber {
                if inputNumber == validNumber {
                    self.isValidNumber = true
                    self.alert("정답입니다..", completion: nil)
                } else {
                    self.alert("인증 번호를 다시 확인해주세요.", completion: nil)
                }
            }
        }
    }
    
    @IBAction func didTapEnrollBtn(_ sender: Any) {
        if self.isValidEmail == true && self.isValidNumber == true {
            if let pwd = self.inputPwdTextField.text,
               let pwdValid = self.validPwdTextField.text,
               let email = self.inputEmailTextField.text {
                if pwd == pwdValid {
                    //1. 포스트 요청, 받은 토큰 저장
                    MemberServiceAPIManager().Enroll(User(email: email, password: pwd)) { tokenStr, error in
                        if let tokenStr = tokenStr {
                            print("tokenStr: \(tokenStr)")
                            SecurityUtils().save("com.winder.Prototype-APILogin", account: email, value: tokenStr)
                            self.performSegue(withIdentifier: "ID-unwindToProfileVC", sender: self)
                        } else if let error = error {
                            self.alert(error.localizedDescription, completion: nil)
                        }
                    }
                    //2. 프로필 화면 갱신하면서 Exit
                } else {
                    self.alert("비밀번호를 다시 확인해주세요.", completion: nil)
                }
            } else {
                self.alert("이메일 인증이 필요합니다.", completion: nil)
            }
        }
    }
    
    func setUpProfileVC(_ email: String, destination: UIViewController) {
        guard let dest = destination as? ProfileVC else {
            return
        }
        dest.paramEmail = email
    }
    
    @IBAction func didTapRefreshBtn(_ sender: Any) {
        self.isValidNumber = false
        self.isValidEmail = false
        // 텍스트필드 입력값 없애기
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ID-unwindToProfileVC" {
            if let email = self.inputEmailTextField.text {
                self.setUpProfileVC(email, destination: segue.destination)
            }
        }
    }
}

// MARK: -- 텍스트필드 델리게이트
extension SignUpVC {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("\(#function), \(textField)")
        textField.resignFirstResponder()
        return true
    }
    
    //
}
