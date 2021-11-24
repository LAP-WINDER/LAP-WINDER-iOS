//
//  ScrollVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/20.
//

import Foundation
import UIKit

class ScrollVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textLabel: UILabel! {
        didSet {
            textLabel.lineBreakMode = .byWordWrapping
        }
    }
    
    var beforeLabelConst: NSLayoutConstraint!
    var afterLabelConst: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpSize()
    }
    @IBOutlet weak var ShowLabelbtn: UIButton! {
        didSet {
            ShowLabelbtn.setTitle("전체보기", for: .normal)
        }
    }
    @IBAction func dynamicViewLabelBtn(_ sender: UIButton) {
        if self.ShowLabelbtn.titleLabel?.text == "전체보기" {
            stackView.subviews[0].constraints[stackView.subviews[0].constraints.endIndex - 1].isActive = false
            print("before: \(self.textLabel.frame.size.height)")
            self.textLabel.numberOfLines = 0
            self.textLabel.sizeToFit()
            print("after: \(self.textLabel.frame.size.height)")
            stackView.subviews[0].heightAnchor.constraint(equalToConstant: self.textLabel.frame.size.height).isActive = true
            ShowLabelbtn.setTitle("접기", for: .normal)
        } else {
            stackView.subviews[0].constraints[stackView.subviews[0].constraints.endIndex - 1].isActive = false
            print("before: \(self.textLabel.frame.size.height)")
            self.textLabel.numberOfLines = 3
            self.textLabel.sizeToFit()
            print("after: \(self.textLabel.frame.size.height)")
            stackView.subviews[0].heightAnchor.constraint(equalToConstant: self.textLabel.frame.size.height).isActive = true
            ShowLabelbtn.setTitle("전체보기", for: .normal)
        }
    }
    
    private func setUpSize() {
        stackView.subviews[0].heightAnchor.constraint(equalToConstant: self.textLabel.frame.size.height).isActive = true
    }
    
}
