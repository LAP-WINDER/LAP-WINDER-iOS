//
//  CameraVC.swift
//  Winder
//
//  Created by 이동규 on 2021/11/12.
//

import Foundation
import UIKit

class CameraVC: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var CameraImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var paramWineID: Int64?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.imagePicker.delegate = self
    }
    
    @IBAction func didTapCaptureBtn(_ sender: Any) {
        // 델리게이트에 정의해놓은 함수 실행
        self.openCamera()
    }
    
    @IBAction func didTapPushBtn(_ sender: Any) {
        //self.alert("사진이 전송되어 분석 중 입니다.", completion: nil)
        self.spinner.startAnimating()
        sleep(2)
        self.spinner.stopAnimating()
        self.spinner.hidesWhenStopped = true
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
            guard let infoVC = segue.destination as? WineInfoVC else { return }
            //infoVC.modalPresentationStyle = .fullScreen
            //self.navigationItem.searchController?.isActive = false
            print(self.paramWineID)
            WineModel().loadDetailFromAPI(wineID: self.paramWineID ?? 1591326) { wineDetail in
                if let wineDetail = wineDetail {
                    infoVC.wineDetail = wineDetail
                }
            }
        }
        //+
    }
    
    //+
}
