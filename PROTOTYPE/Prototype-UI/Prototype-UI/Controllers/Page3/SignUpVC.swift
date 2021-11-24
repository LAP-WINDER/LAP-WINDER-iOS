//
//  SignUpVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/15.
//

import Foundation
import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var lastTF: UITextField!
    @IBOutlet weak var lastPaddingView: UIView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastTF.delegate = self
        setUpNotifi()
    }
    
    @IBAction func didTapDissmisBarBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUpNotifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func printConstBtn(_ sender: Any) {
//        self.lastPaddingView.constraints[0].constant += 10
//        print(self.lastPaddingView.constraints[0].constant)
        print(self.scrollview.constraints)
        print(self.lastTF.frame)
    }
    
    var keyHeight: CGFloat?
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        keyHeight = keyboardHeight

        //
        //self.view.frame.size.height -= keyboardHeight
        self.scrollview.frame.origin.y -= keyboardHeight
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
         //self.view.frame.size.height += keyHeight!
        self.scrollview.frame.origin.y += keyHeight!
     }
    //+
}

extension SignUpVC: UITextFieldDelegate {
    
}
