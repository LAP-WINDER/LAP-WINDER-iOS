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
        recomendedContentsView.setUpContentsView()
        newsContentsView.setUpStackView { imageView in
            self.addGestureToUIView(imageView)
        }
        blogContentsView.setUpStackView { imageView in
            self.addGestureToUIView(imageView)
        }
        infoStackView.setUpStackView { imageView in
            self.addGestureToUIView(imageView)
        }
        self.setupNavBarSettings()
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
}
