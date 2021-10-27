//
//  HomeVC.swift
//  Prototype_HomeVC
//
//  Created by 이동규 on 2021/10/26.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSettings()
    }
    
    func setUpSettings() {
        // 레이아웃 제약사항
        /*
        NSLayoutConstraint.activate([
            self.scrollview.topAnchor.constraint(equalTo: (self.navigationController?.navigationItem.titleView?.bottomAnchor) as NSLayoutAnchor<NSLayoutYAxisAnchor>)
        ])
        */
        self.scrollview.contentInsetAdjustmentBehavior = .never

        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}
