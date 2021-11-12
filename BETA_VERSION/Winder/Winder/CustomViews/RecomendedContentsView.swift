//
//  RecomendedContentsView.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation
import UIKit

class RecomendedContentsView: UIView {
    
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var contentsImageView: UIImageView!
    @IBOutlet weak var contentsPageCtrl: UIPageControl!
    
    let contentsImagesPath = ["WinerySample.png", "test_2.jpeg", "test_3.jpeg"]
    
    func setUpContentsView() {
        self.contentsPageCtrl.numberOfPages = self.contentsImagesPath.count
        self.contentsPageCtrl.currentPage = 0
        self.contentsPageCtrl.pageIndicatorTintColor = .lightGray
        self.contentsPageCtrl.currentPageIndicatorTintColor = .black
        self.contentsImageView.image = UIImage(named: self.contentsImagesPath[self.contentsPageCtrl.currentPage])
        self.contentsImageView.contentMode = .scaleAspectFill
        self.contentsImageView.layer.cornerRadius = 25
        self.contentsImageView.clipsToBounds = true
        self.contentsImageView.isUserInteractionEnabled = true
        addGestureContents(contentsImageView)
    }
    
    func addGestureContents(_ uiView: UIImageView) {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = .left
        uiView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = .right
        uiView.addGestureRecognizer(swipeRight)
        //페이지 넘어가는것도 추가
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        // 만일 제스쳐가 있다면
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            // 발생한 이벤트가 각 방향의 스와이프 이벤트라면 해당 이미지 뷰를 빨간색 화살표 이미지로 변경
            var pagePostion = self.contentsPageCtrl.currentPage
            switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.left :
                if pagePostion ==  self.contentsImagesPath.count - 1 {
                    pagePostion = 0
                } else {
                    pagePostion += 1
                }
                case UISwipeGestureRecognizer.Direction.right :
                if pagePostion == 0 {
                    pagePostion = self.contentsImagesPath.count - 1
                } else {
                    pagePostion -= 1
                }
                default:
                    break
            }
            self.contentsPageCtrl.currentPage = pagePostion
            self.contentsImageView.image = UIImage(named:
                                                    self.contentsImagesPath[self.contentsPageCtrl.currentPage])
        }
    }
    
    //+
}
