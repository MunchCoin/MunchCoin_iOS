//
//  CameraViewControllerDelegate.swift
//  MunchCoin
//
//  Created by Developer on 12/5/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let cgim = photo.previewCGImageRepresentation()?.takeRetainedValue() {
//            let image = UIImage(cgImage: cgim, scale: 1, orientation: .up)
            print("I made an image")
        }
    }
}
