//
//  CameraVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation
import UIKit

class CameraVC: UIViewController {
    
    @IBOutlet weak var CameraImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
    }
    
    @IBAction func didTapCaptureBtn(_ sender: Any) {
        // 델리게이트에 정의해놓은 함수 실행
        self.openCamera()
    }
    
    @IBAction func didTapPushBtn(_ sender: Any) {
        // 뷰에 보여지고 있는 데이터 래핑
        let capturedImageModel = CapturedImageModel(capturedImage: self.CameraImageView.image, paramName: "fieldname", fileName: "capturedUserInput.png")
        //서버에 푸쉬하고 결과 받아야함
        MLServiceAPIManager().uploadPictureAndGetResult(capturedImageModel) { str in
            print(str ?? "nothing yet") //
        }
    }
    
    
}
