//
//  HomeInfoVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation
import UIKit
import WebKit

class HomeInfoVC: UIViewController {
    
    @IBOutlet weak var wkView: WKWebView!
    var paramContentsID: Int?
    var paramContentsURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
    }
    
    private func setUpWebView() {
        var str: String = ""
        if let urlStr = self.paramContentsURL {
            str = urlStr
        }
        let url = URL(string: str)
        let request = URLRequest(url: url!)
        self.wkView.load(request)
    }
}
