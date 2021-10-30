//
//  TestVC.swift
//  Prototype-SearchList
//
//  Created by 이동규 on 2021/10/26.
//

import Foundation
import UIKit

class TestVC: UIViewController {
    
    var wineModel = WineModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wineModel.loadFromJson()
    }
}
