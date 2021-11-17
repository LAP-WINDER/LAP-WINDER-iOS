//
//  WineInfoVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/17.
//

import Foundation
import UIKit

class WineInfoVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentsStackView: UIStackView!
    @IBOutlet weak var firstContentView: UIView!
    @IBOutlet weak var secondContentView: UIView!
    @IBOutlet weak var wineImageView: UIImageView!
    
    @IBOutlet weak var dismisBtn: UIButton!
    @IBOutlet weak var likeWineBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    var isStatusBarStyleDefault: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarHidden()
        self.scrollView.delegate = self
        self.setUpBtnStyle()
        self.setUpStatusBarStyle(color: UIColor.getWinderColor(.pink), statusBarStyle: false)
        
        print(self.contentsStackView.layer)
        //self.contentsStackView.setCustomSpacing(-100, after: self.firstContentView)
        //self.contentsStackView.spacing = -10
        self.secondContentView.layer.cornerRadius = 30
        self.secondContentView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private func setUpStatusBarStyle(color: UIColor, statusBarStyle: Bool) {
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
        self.isStatusBarStyleDefault = statusBarStyle
        setNeedsStatusBarAppearanceUpdate() // 이걸해줘야 상태바 최신화됨...
    }
    
    private func setUpBtnStyle() {
        self.dismisBtn.setTitle("", for: .normal)
        self.likeWineBtn.setTitle("", for: .normal)
        self.bookmarkBtn.setTitle("", for: .normal)
        
        self.dismisBtn.layer.cornerRadius = self.dismisBtn.frame.height / 4
        self.likeWineBtn.layer.cornerRadius = self.likeWineBtn.frame.height / 4
        self.bookmarkBtn.layer.cornerRadius = self.bookmarkBtn.frame.height / 4
    }
    
    @IBAction func didTapCancelBtn(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapLikeBtn(_ sender: Any) {
        self.alert("서비스 준비중입니다.", completion: nil)
    }
    
    @IBAction func didTapBookmarkBtn(_ sender: Any) {
        self.alert("서비스 준비중입니다.", completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navBarHidden()
    }
    
    func navBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        //self.navigationItem.searchController?.searchBar.isHidden = true
        //self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.isStatusBarStyleDefault ? .darkContent : .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

// MARK: - 스크롤뷰 델리게이트
extension WineInfoVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= self.firstContentView.frame.height + self.secondContentView.layer.cornerRadius {
            self.setUpStatusBarStyle(color: UIColor.white, statusBarStyle: true)
        } else {
            self.setUpStatusBarStyle(color: UIColor.getWinderColor(.pink), statusBarStyle: false)
        }
    }
    //+
}
