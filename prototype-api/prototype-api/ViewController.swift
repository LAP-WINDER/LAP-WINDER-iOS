//
//  ViewController.swift
//  prototype-api
//
//  Created by 이동규 on 2021/10/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.emailLabel.text = "확인되지 않았습니다."
        self.passwordLabel.text = "확인되지 않았습니다."
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        if webservice().isValidUser(User(email: "test1@test.com", password: "password")) {
            print("yesyes")
        } else {
            print("nono")
        }
    }
    
    
}

