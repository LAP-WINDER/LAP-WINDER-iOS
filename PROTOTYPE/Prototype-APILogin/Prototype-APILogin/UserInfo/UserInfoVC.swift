//
//  UserInfoVC.swift
//  Prototype-APILogin
//
//  Created by 이동규 on 2021/11/10.
//

import Foundation
import UIKit

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUserInfo()
    }
    
    private func setUpUserInfo() {
        MemberServiceAPIManager().requestUserInfo()
    }
    
    //+
}
