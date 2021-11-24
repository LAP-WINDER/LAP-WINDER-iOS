//
//  SignUpOriginVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/20.
//

import Foundation
import UIKit

class SignUpOriginVC: UIViewController {
    
    @IBOutlet weak var firstTF: UITextField! { didSet { firstTF.delegate = self } }
    @IBOutlet weak var secondTF: UITextField! { didSet { secondTF.delegate = self } }
    @IBOutlet weak var thirdTF: UITextField! { didSet { thirdTF.delegate = self } }
    
    @IBOutlet weak var lastTF: UITextField! {
        didSet {
            lastTF.accessibilityValue = "lastTF"
        }
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastTF.delegate = self
        self.setUpNotifi()
    }
    
    func setUpStatusBarStyle(color: UIColor) {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            let statusBarHeight: CGFloat = (window?.windowScene?.statusBarManager?.statusBarFrame.height)!
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
        setNeedsStatusBarAppearanceUpdate() // 이걸해줘야 상태바 최신화됨...
    }
    
    private func setUpNotifi() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var keyHeight: CGFloat = 0.0
    
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyHeight <= self.view.frame.height - keyboardSize.height {
                return
            }
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        self.keyHeight = 0
    }
    
    
//    @objc func keyboardWillShow(_ sender: Notification) {
//        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
//        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
//        let keyboardRectangle = keyboardFrame.cgRectValue
//        let keyboardHeight = keyboardRectangle.height
//        keyHeight = keyboardHeight
//
//        //
//        //self.view.frame.size.height -= keyboardHeight
//        self.view.window?.frame.origin.y -= keyboardHeight + 20
//        self.setUpStatusBarStyle(color: .white)
//        // 상태바 흰색으로 마스킹하기
//
//
//    }
    
//    @objc func keyboardWillHide(_ sender: Notification) {
//         //self.view.frame.size.height += keyHeight!
//        self.view.window?.frame.origin.y += keyHeight! - 20
//        self.setUpStatusBarStyle(color: .clear)
//     }
    
    
    //+
}

extension SignUpOriginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.accessibilityValue == "lastTF" {
            self.keyHeight = textField.frame.origin.y + textField.frame.height
        } else {
            self.keyHeight = 0
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
