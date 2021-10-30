//
//  TestHomeVC.swift
//  Prototype_HomeVC
//
//  Created by 이동규 on 2021/10/27.
//

import Foundation
import UIKit

class TestHomeVC: UIViewController {
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
    }
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
