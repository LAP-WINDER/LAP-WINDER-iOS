//
//  PopUpToShowResultVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/18.
//  머신러닝 결과 알림 팝업뷰

import Foundation
import UIKit


class PopUpToShowResultVC: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var dismissBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPopUpView()
    }
    
    private func setUpPopUpView() {
        self.backgroundView.backgroundColor = .systemGray.withAlphaComponent(0.7)
        self.popupView.layer.cornerRadius = 20
        self.dismissBtn.setTitle("", for: .normal)
        self.dismissBtn.tintColor = UIColor.getWinderColor(.violet)
    }
    
    @IBAction func didTapDismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapYesBtn(_ sender: Any) {
        guard let mainTBC = self.presentingViewController as? MainTBC else { return }
        guard let preVC = mainTBC.viewControllers?[2].children[0] as? CameraVC else { return }
        self.dismiss(animated: true) {
            preVC.performSegue(withIdentifier: "ID-manual-CameraVC-WineInfoVC", sender: nil)
        }
    }
    
    @IBAction func didTapNoBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //+
}
