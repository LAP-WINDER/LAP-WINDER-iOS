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
        print(#function)
        self.imagePicker.delegate = self
    }
    
    @IBAction func didTapCaptureBtn(_ sender: Any) {
        // 델리게이트에 정의해놓은 함수 실행
        self.openCamera()
    }
    
    @IBAction func didTapPushBtn(_ sender: Any) {
        //self.alert("사진이 전송되어 분석 중 입니다.", completion: nil)
        guard let popupResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ID-PopUpToShowResultVC") else { return }
        popupResultVC.modalPresentationStyle = .overFullScreen
        self.present(popupResultVC, animated: true, completion: nil)
        
        /*
        // 뷰에 보여지고 있는 데이터 래핑
        let capturedImageModel = CapturedImageModel(capturedImage: self.CameraImageView.image, paramName: "fieldname", fileName: "capturedUserInput.png")
        //서버에 푸쉬하고 결과 받아야함
        MLServiceAPIManager().uploadPictureAndGetResult(capturedImageModel) { str in
            print(str ?? "nothing yet") //
        }
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ID-manual-CameraVC-WineInfoVC" {
            // 나중에 API 데이터 전송
        }
    }
    
    //+
}
