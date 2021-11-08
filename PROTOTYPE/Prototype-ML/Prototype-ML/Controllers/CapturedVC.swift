//
//  CapturedVC.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/08.
//

import Foundation
import UIKit

class CapturedVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var paramCaptured: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let img = self.paramCaptured {
            self.imageView.image = img
        }
    }
}
