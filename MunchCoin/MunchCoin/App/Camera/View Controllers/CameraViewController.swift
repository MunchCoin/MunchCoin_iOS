//
//  CameraViewController.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    
    var captureButton: UIButton = UIButton()
    var session: AVCaptureSession = AVCaptureSession()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
            configureViews()
        // Do any additional setup after loading the view.
    }
    
    func configureViews() {
        session.beginConfiguration()
        guard session.canSetSessionPreset(session.sessionPreset) else {
            return
        }
        
        session.sessionPreset = .photo
        let output = AVCapturePhotoOutput()
        guard session.canAddOutput(output) else {
            return
        }
        
        session.addOutput(output)
        
        session.commitConfiguration()
        guard let cam = AVCaptureDevice.default(for: .video),
            let input = try? AVCaptureDeviceInput(device: cam)
            else {return}
        
        session.addInput(input)
        let lay = AVCaptureVideoPreviewLayer(session: session)
        lay.frame = view.frame
        lay.videoGravity = .resizeAspectFill
        view.layer.addSublayer(lay)
        session.startRunning()
        
        view.addSubview(captureButton)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        captureButton.heightAnchor.constraint(equalToConstant: 83).isActive = true
        captureButton.widthAnchor.constraint(equalToConstant: 83).isActive = true
        captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        captureButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        captureButton.backgroundColor = .clear
        captureButton.layer.cornerRadius = 83/2
        captureButton.layer.borderColor = Branding.Color.yellow.cgColor
        captureButton.layer.borderWidth = 5
        captureButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
        
        
    }
    
    @objc func captureImage() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        let pbpf = settings.availablePreviewPhotoPixelFormatTypes.first!
        settings.previewPhotoFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: pbpf,
            kCVPixelBufferWidthKey as String: 95,
            kCVPixelBufferHeightKey as String: 203
        ]
        guard let output = session.outputs.first as? AVCapturePhotoOutput else {
            return
        }
        
        output.capturePhoto(with: settings, delegate: self)
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
