//
//  LogInVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/15.
//

import Foundation
import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var CancelBtn: UIImageView! {
        didSet {
            CancelBtn.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self,
                                                    action: #selector(justDismissTap(sender:))
            )
            self.CancelBtn.addGestureRecognizer(tapGesture)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        self.logoImgView.image = UIImage(named: "app_logo_full")
    }
    
    @objc func justDismissTap(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}
