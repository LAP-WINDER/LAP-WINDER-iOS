//
//  HomeVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var recomendedContentsView: RecomendedContentsView!
    @IBOutlet weak var newsContentsView: NewsContentsView!
    @IBOutlet weak var blogContentsView: BlogContentsView!
    @IBOutlet weak var infoStackView: InfoContentsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpAllViews()
        self.setupNavBarSettings()
    }
    
    func setUpAllViews() {
        self.recomendedContentsView.setUpContentsView()
        self.newsContentsView.setUpStackView { imageView in
            self.addGestureToUIView(imageView)
        }
        self.blogContentsView.setUpStackView { imageView in
            self.addGestureToUIView(imageView)
        }
        self.infoStackView.setUpStackView { imageView in
            self.addGestureToUIView(imageView)
        }
    }
    
    func setupNavBarSettings() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func addGestureToUIView(_ uiview: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        uiview.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "ID-manual-HomeVC-HomeInfoVC", sender: self)
    }
    
    //+
}
