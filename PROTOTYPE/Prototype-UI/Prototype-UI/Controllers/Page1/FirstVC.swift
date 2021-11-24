//
//  FirstVC.swift
//  Prototype-UI
//
//  Created by 이동규 on 2021/11/09.
//

import Foundation
import UIKit

//Color pink RGB: (251,163,216)
//Color purple RGB: (93,76,201)

class FirstVC: UIViewController {
    
    @IBOutlet weak var contentsImageView: UIImageView!
    
    @IBOutlet var contentsImageViewList: [UIImageView]!
    
    @IBOutlet weak var contentsPageCtrl: UIPageControl!
    var images = ["oasis_1.jpeg", "oasis_2.jpeg", "oasis_3.jpeg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContentsView()
    }
    
    func setUpContentsView() {
        self.contentsPageCtrl.numberOfPages = self.images.count
        self.contentsPageCtrl.currentPage = 0
        self.contentsPageCtrl.pageIndicatorTintColor = .lightGray
        self.contentsPageCtrl.currentPageIndicatorTintColor = .black
        self.contentsImageView.image = UIImage(named: self.images[self.contentsPageCtrl.currentPage])
        self.contentsImageView.contentMode = .scaleAspectFill
        self.contentsImageView.layer.cornerRadius = 25
        self.contentsImageView.clipsToBounds = true
        self.contentsImageView.isUserInteractionEnabled = true
        addGestureContents(contentsImageView)
        
        //팬제스쳐용
        self.contentsImageView.image = UIImage(named: self.images[self.contentsPageCtrl.currentPage])
        self.contentsImageView.contentMode = .scaleAspectFill
        self.contentsImageView.layer.cornerRadius = 25
        self.contentsImageView.clipsToBounds = true
        self.contentsImageView.isUserInteractionEnabled = true
    }
    
    func addGestureContents(_ uiView: UIImageView) {
        /*
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = .left
        uiView.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeRight.direction = .right
        uiView.addGestureRecognizer(swipeRight)
        //페이지 넘어가는것도 추가
         */
        
        // 팬제스쳐로 변경
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(_:)))
        self.contentsImageView.addGestureRecognizer(panGesture)
    }
    
    @objc func wasDragged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        let image = gesture.view
        
        view.bringSubviewToFront(image!)

        image!.center = CGPoint(x: (image?.center.x)! + translation.x, y: (image?.center.y)! + translation.y)
        gesture.setTranslation(CGPoint.zero, in: self.view)

    }

    
    // handle UIPanGestureRecognizer
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
         let gview = recognizer.view
         if recognizer.state == .began || recognizer.state == .changed {
              let translation = recognizer.translation(in: gview?.superview)
              gview?.center = CGPoint(x: (gview?.center.x)! + translation.x, y: (gview?.center.y)! + translation.y)
              recognizer.setTranslation(CGPoint.zero, in: gview?.superview)
         }
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        // 만일 제스쳐가 있다면
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            // 발생한 이벤트가 각 방향의 스와이프 이벤트라면 해당 이미지 뷰를 빨간색 화살표 이미지로 변경
            var pagePostion = self.contentsPageCtrl.currentPage
            switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.left :
                if pagePostion ==  self.images.count - 1 {
                    pagePostion = 0
                } else {
                    pagePostion += 1
                }
                case UISwipeGestureRecognizer.Direction.right :
                if pagePostion == 0 {
                    pagePostion = self.images.count - 1
                } else {
                    pagePostion -= 1
                }
                default:
                    break
            }
            self.contentsPageCtrl.currentPage = pagePostion
            self.contentsImageView.image = UIImage(named:
                                                    self.images[self.contentsPageCtrl.currentPage])
        }
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        self.contentsImageView.image = UIImage(named: self.images[self.contentsPageCtrl.currentPage])
    }
    
    
    @IBAction func testPrintBtn(_ sender: Any) {
        WineModel2().loadFromAPI { wineCellList in
            if let wineCellList = wineCellList {
                print("hello?", wineCellList, type(of: wineCellList))
                print("ttttt")
                for i in wineCellList {
                    print("iiiiii ", type(of: wineCellList), type(of: i), i)
                }
            }
        }
    }
    
    @IBAction func testPrintDetailBtn(_ sender: Any) {
        WineModel2().loadDetailFromAPI(wineID: 1591326) { wineDetail in
            print("hello?!?!?!", wineDetail, type(of: wineDetail))
        }
    }
    
    
    //+
}
