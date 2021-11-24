//
//  testVC.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/21.
//

import Foundation
import UIKit

class testVC: UIViewController {
    
    
    @IBAction func testprint(_ sender: Any) {
        SearchWineAPIManager().setList {
            print("test")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
