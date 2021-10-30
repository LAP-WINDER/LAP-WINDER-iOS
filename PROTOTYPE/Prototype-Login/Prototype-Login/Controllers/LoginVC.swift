//
//  LoginVC.swift
//  Prototype-Login
//
//  Created by 이동규 on 2021/10/26.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func didTapSubmitButton(_ sender: Any) {
        if let email = self.emailTextField.text, let pwd = self.passwordTextField.text {
            let vc = self.presentingViewController
            print("herere", vc)
            guard let preVC = self.presentingViewController as? MainTBC else {
                print("Why am i here")
                return
            }
            if let profileVC = preVC.viewControllers?[1] as? ProfileVC {
                profileVC.paramEmail = email
                profileVC.paramPassword = pwd
                print(profileVC.paramEmail, profileVC.paramPassword)
                DispatchQueue.main.async {
                    preVC.viewWillAppear(true)
                }
            }
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
            print("nono")
        }
    }
    
}
