//
//  QRScanner.swift
//  QRgeneratorReader
//
//  Created by Ivica Petrsoric on 06/04/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanner: UIViewController {
    
    private var video = AVCaptureVideoPreviewLayer()
    private var session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        // creating session
//        let session = AVCaptureSession()
        
        // define capture device
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
            
        } catch {
            print("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        
        view.layer.addSublayer(video)
        
        session.startRunning()
    }    
    
}

extension QRScanner: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == .qr {
                    session.stopRunning()
                    
                    let alert = UIAlertController(title: "QR code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: { (_) in
                        self.session.startRunning()
                    }))
                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (_) in
                        UIPasteboard.general.string = object.stringValue
                        self.session.startRunning()
                    }))
                    
                    present(alert, animated: true, completion: nil)

                }
            }
        }
    }
    
}
