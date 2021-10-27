//
//  HomeVC.swift
//  Prototype_01
//
//  Created by 이동규 on 2021/10/24.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var newsStackView: UIStackView!
    @IBOutlet weak var blogStackView: UIStackView!
    @IBOutlet weak var countriesStackView: UIStackView!

    func addGestureToUIView(_ uiview: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        uiview.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "ID-Manual-HomeVC-HomeInfoVC", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarSettings()
        //addGestureToUIView()
        setUpViewsInStackView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
    
    func setupNavBarSettings() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpViewsInStackView() {
        self.newsStackView.spacing = 10
        self.blogStackView.spacing = 10
        self.countriesStackView.spacing = 10
        
        // 하드코딩해놓은거 각각 섹션마다 다르게 UI 처리적용해야됨.
        for _ in 0..<3 {
            let uiimageview = UIImageView()
            //uiimageview.backgroundColor = .systemBlue
            uiimageview.image = UIImage(named: "WinerySample.jpg")
            uiimageview.backgroundColor = .systemBlue
            uiimageview.layer.cornerRadius = 25
            uiimageview.clipsToBounds = true
            uiimageview.isUserInteractionEnabled = true
            addGestureToUIView(uiimageview)
            uiimageview.widthAnchor.constraint(equalToConstant: self.newsStackView.frame.height).isActive = true
            self.newsStackView.addArrangedSubview(uiimageview)
        }
        
        for _ in 0..<3 {
            let uiimageview = UIImageView()
            //uiimageview.backgroundColor = .systemBlue
            uiimageview.image = UIImage(named: "42.jpg")
            uiimageview.backgroundColor = .systemBlue
            uiimageview.layer.cornerRadius = 25
            uiimageview.clipsToBounds = true
            uiimageview.isUserInteractionEnabled = true
            addGestureToUIView(uiimageview)
            uiimageview.widthAnchor.constraint(equalToConstant: self.blogStackView.frame.height).isActive = true
            self.blogStackView.addArrangedSubview(uiimageview)
        }
        
        for _ in 0..<3 {
            let uiimageview = UIImageView()
            //uiimageview.backgroundColor = .systemBlue
            uiimageview.image = UIImage(named: "WinerySample.jpg")
            uiimageview.backgroundColor = .systemBlue
            uiimageview.layer.cornerRadius = 25
            uiimageview.clipsToBounds = true
            uiimageview.isUserInteractionEnabled = true
            addGestureToUIView(uiimageview)
            uiimageview.widthAnchor.constraint(equalToConstant: self.countriesStackView.frame.height).isActive = true
            self.countriesStackView.addArrangedSubview(uiimageview)
        }
    }
}
