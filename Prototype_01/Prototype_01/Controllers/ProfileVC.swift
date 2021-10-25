//
//  ProfileVC.swift
//  Prototype_01
//
//  Created by 이동규 on 2021/10/25.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    var paramEmail: String?
    var paramPassword: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailLabel.text = "확인되지 않았습니다."
        self.passwordLabel.text = "확인되지 않았습니다."
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ID-Action-toLoginVC" {
            if let loginvc = self.storyboard?.instantiateViewController(withIdentifier: "ID-LoginVC") as? LoginVC {
                loginvc.modalPresentationStyle = .fullScreen
                self.present(loginvc, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("heeerer, \(self.paramEmail)\(self.paramPassword)")
        if let email = self.paramEmail {
            self.emailLabel?.text = email
            print("heerer 1, \(email)")
        }
        if let pwd = self.paramPassword {
            self.passwordLabel?.text = pwd
            print("heerer 2, \(pwd)")
        }
    }
    
}
