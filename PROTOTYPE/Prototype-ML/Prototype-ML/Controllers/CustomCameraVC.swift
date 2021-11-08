//
//  CustomCameraVC.swift
//  Prototype-ML
//
//  Created by 이동규 on 2021/11/08.
//

import Foundation
import AVFoundation
import UIKit

class CustomCameraVC: UIViewController {
    
    @IBOutlet weak var cameraView: UIView!
    var captureSession: AVCaptureSession!
    
    var backCamera: AVCaptureDevice!
    var frontCamera: AVCaptureDevice!
    
    var backCameraInput: AVCaptureInput!
    var frontCameraInput: AVCaptureInput!
    
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var videoOutput: AVCaptureVideoDataOutput!
    var photoOutput = AVCapturePhotoOutput()

    var takePicture = false
    var isBackCamera = true
    
    @IBAction func didTapCaptureBtn(_ sender: Any) {
        captureOutput(self.photoOutput, didOutput: nil, from: <#T##AVCaptureConnection#>)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCustomCamera()
    }
    
    func setUpCustomCamera() {
        self.captureSession = AVCaptureSession()
        
        // captureSession에 대한 설정시작.
        self.captureSession.beginConfiguration()
        // 해상도 설정
        if self.captureSession.canSetSessionPreset(.photo) {
            self.captureSession.sessionPreset = .photo
        }
        
        // 후면 카메라 디바이스 설정
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            self.backCamera = device
        } else {
            fatalError("후면 카메라가 없어요.")
        }
        
        // 전면 카메라 디바이스 설정
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            self.frontCamera = device
        } else {
            fatalError("전면 카메라가 없어요.")
        }
        
        // Output data 관련
        photoOutput.connections.first?.videoOrientation = .portrait
        
        // 세팅 저장
        var photoSettings : AVCapturePhotoSettings?
        
        // captureSession 에 Input data 를 제공하는 object
        do {
            let backCameraDeviceInput = try  AVCaptureDeviceInput(device: self.backCamera)
            let frontCameraDeviceInput = try AVCaptureDeviceInput(device: self.frontCamera)

            if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
            } else {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            }
            // captureSession에 camera input 을 받도록 추가
            self.captureSession.addInput(backCameraDeviceInput)
            self.captureSession.addOutput(photoOutput)
            
        } catch {
            fatalError(error.localizedDescription)
        }
        
        self.previewLayer =  AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.previewLayer.videoGravity = .resizeAspectFill
        self.previewLayer.connection?.videoOrientation = .portrait
        self.previewLayer.frame = self.cameraView.frame
        cameraView.layer.insertSublayer(self.previewLayer, at: 0)
        
    
        
        // 세션 시작
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
}

// MARK: -- 찍은 사진을 저장하기 위해서 델리게이트 프로토콜 채택
extension CustomCameraVC: AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if !takePicture {
            return
        }
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
        let uiImage = UIImage(ciImage: ciImage)
        self.takePicture = false
        self.captureSession.stopRunning()
        
        DispatchQueue.main.async {
            guard let pictureViewController = self.storyboard?.instantiateViewController(withIdentifier: "ID-CapturedVC") as? CapturedVC else { return }
            pictureViewController.paramCaptured = uiImage
        }
        
    }
    /*
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            NSLog(error?.localizedDescription ?? "Output Error.")
            return
        }
        // 사진 앨범에 접근 권한을 요청
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {return}
            // 사진 앨범에 저장.
            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, data: photo.fileDataRepresentation()!, options: nil)
             }, completionHandler: nil)
         }
    }
     */
}
