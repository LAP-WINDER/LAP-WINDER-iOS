//
//  ProfileVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/09.
//

import Foundation
import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileView()
    }
    
    func setUpProfileView() {
        
    }
    
    @IBAction func didTapLoginBtn(_ sender: Any) {
        performSegue(withIdentifier: "ID-manual-to-LoginVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ID-manual-to-LoginVC" {
            if let loginvc = self.storyboard?.instantiateViewController(withIdentifier: "ID-LoginVC") as? LoginVC {
                loginvc.modalPresentationStyle = .fullScreen
                self.present(loginvc, animated: true, completion: nil)
            }
        }
    }
}
