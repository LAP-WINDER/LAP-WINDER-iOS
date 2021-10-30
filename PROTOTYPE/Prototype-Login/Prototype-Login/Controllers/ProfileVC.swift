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
