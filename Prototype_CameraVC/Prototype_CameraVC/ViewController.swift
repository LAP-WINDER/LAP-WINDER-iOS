//
//  ViewController.swift
//  Prototype_CameraVC
//
//  Created by 이동규 on 2021/10/24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    
    // UIImagePickerController의 인스턴스 변수 생성
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    // 사진을 저장할 변수
    var captureImage: UIImage!
    // 녹화한 비디오의 URL을 저장할 변수
    var videoURL: URL!
    // 사진 저장 여부를 나타낼 변수
    var flagImageSave = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapCaptureImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.flagImageSave = true
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = .camera
            self.imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            print("NO")
        }
    }
    
    @IBAction func didTapCaptureVideo(_ sender: Any) {
    }
    
    @IBAction func didTapLoadImage(_ sender: Any) {
    }
    
    @IBAction func didTapLoadVideo(_ sender: Any) {
    }
    
}

