//
//  CameraVC.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/03.
//

import Foundation
import UIKit

class CameraVC: UIViewController {
    
    @IBOutlet weak var CameraImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSegmentControl()
        self.imagePicker.delegate = self
    }
    
    func setUpSegmentControl() {
        //let titles = ["바코드 스캐너", "머신러닝 분석"]
    }
    
    @IBAction func didTapCaptureBtn(_ sender: Any) {
        self.openCamera()
    }
    
    @IBAction func didTapPushBtn(_ sender: Any) {
        let capturedImageModel = CapturedImageModel(capturedImage: self.CameraImageView.image, paramName: "fieldname", fileName: "test_api.png")
        MLService().uploadPictureAndGetResult(capturedImageModel) { str in
            print(str ?? "nothing yet")
        }
    }
}

extension CameraVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    // 카메라 세팅
    func openCamera() {
        self.imagePicker.sourceType = .camera   // 컨트롤러 기능 중 카메라 기능 사용
//        self.modalPresentationStyle = .fullScreen
        self.imagePicker.allowsEditing = false  // 편집 허용 x
        self.imagePicker.cameraDevice = .rear   // 후면 카메라
        self.imagePicker.cameraCaptureMode = .photo
        self.imagePicker.cameraFlashMode = .auto
//        self.imagePicker.showsCameraControls = true
        addOverlay()
        
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    func addOverlay() {
        let overlayView = UIView()
        overlayView.backgroundColor = .none
        overlayView.layer.borderWidth = 1
        overlayView.layer.borderColor = UIColor.black.cgColor
        self.imagePicker.view.subviews[0].alpha = 0.6 
        
        //수정, (self.imagePicker.cameraOverlayView?.layer.position)!
//        let testxy = CGPoint(x: (self.imagePicker.view.layer.sublayers![0].frame.width / 3), y: 0)
        let origin = CGPoint(x: (self.imagePicker.view.layer.sublayers![0].frame.width / 6) * 2, y: 0)
        overlayView.frame = CGRect(origin: origin,
                                   size: CGSize(
                                    width: (self.imagePicker.view.layer.sublayers![0].frame.width / 6) * 2,
                                    height: (self.imagePicker.view.layer.sublayers![0].frame.height))
        )
//        overlayView.frame = self.imagePicker.view.layer.sublayers![0].frame
//        print((self.imagePicker.cameraOverlayView?.frame)!, (self.imagePicker.cameraOverlayView?.layer.position)!)
        print(self.imagePicker.view.layer.sublayers![0].frame.width / 3)
        self.imagePicker.cameraOverlayView = overlayView
        
//        for layer in self.imagePicker.view.layer.sublayers! {
//            print("pickers layer", layer)
//        }
//        print("pickers layer all: ", self.imagePicker.view.layer.sublayers!)
//        cameraView.tag = 101
    }
    
    // Deg2Rad. Meh
    func deg2rad(_ number: Double) -> CGFloat{
        return CGFloat(number * Double.pi/180)
    }
    
    func addSilhouette(_ cameraView: UIView){
        // The base canvas on which everything else is put
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), cornerRadius: 0)
    
        // Semicircle for the silhouette
        let semicircle = UIBezierPath(arcCenter: CGPoint(x: self.view.center.x, y: self.view.center.y), radius: 200.0, startAngle: deg2rad(0), endAngle: deg2rad(180), clockwise: false)
                
        // Chin area of the silhouette
        let freeform = UIBezierPath()
        freeform.move(to: CGPoint(x: self.view.center.x - 200, y: self.view.center.y))
        freeform.addCurve(to: CGPoint(x: self.view.center.x + 200, y: self.view.center.y), controlPoint1: CGPoint(x: self.view.center.x - 180, y: self.view.center.y + 450), controlPoint2: CGPoint(x: self.view.center.x + 180, y: self.view.center.y + 450))
                
        path.append(semicircle)
        path.append(freeform)
        path.usesEvenOddFillRule = true
                
        // Adding the canvas as a sublayer
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillRule = .evenOdd
        fillLayer.opacity = 0.7
        
        cameraView.layer.addSublayer(fillLayer)
    }
    
    // 카메라 찍고 나서 "Use Photo" 버튼 눌렀을 때 호출된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.CameraImageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
}
