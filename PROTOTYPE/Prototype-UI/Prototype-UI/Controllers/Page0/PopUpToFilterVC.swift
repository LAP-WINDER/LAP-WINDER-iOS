//
//  PopUpToFilterVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/16.
//

import Foundation
import UIKit

class PopUpToFilterVC: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPopUpView()
    }
    
    private func setUpPopUpView() {
        //self.popupView.alpha = 5.0
        self.backgroundView.backgroundColor = .systemGray.withAlphaComponent(0.5)
        self.popupView.layer.cornerRadius = 20
        self.dismissBtn.setTitle("", for: .normal)
    }
    
    @IBAction func didTapDismissBtn(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //+
}
