//
//  ViewController.swift
//  QRgeneratorReader
//
//  Created by Ivica Petrsoric on 06/04/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

class QRGenerator: UIViewController {

    private let myImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    private var textQR = "testing QR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(myImageView)
        myImageView.centerInSuperview(size: .init(width: 200, height: 200))
        
        navigationItem.title = "QR"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Generator", style: .plain, target: self, action: #selector(generateQR))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Scanner", style: .plain, target: self, action: #selector(scannQR))
    }
    
    @objc private func scannQR() {
        let scanner = QRScanner()
        navigationController?.pushViewController(scanner, animated: true)
    }
    
    @objc private func generateQR() {
        let data = textQR.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        filter?.setValue(data, forKey: "inputMessage")
        
        // A
        let img = UIImage(ciImage: (filter?.outputImage)!.transformed(by: transform))
        myImageView.image = img
        
        // B
//        myImageView.image = convertTextToQRCode(text: textQR, withSize: CGSize(width:200, height: 200))
    }
    
    func convertTextToQRCode(text: String, withSize size: CGSize) -> UIImage {
        let data = text.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("L", forKey: "inputCorrectionLevel")
        
        let qrcodeCIImage = filter.outputImage!
        
        let cgImage = CIContext(options:nil).createCGImage(qrcodeCIImage, from: qrcodeCIImage.extent)
        UIGraphicsBeginImageContext(CGSize(width: size.width * UIScreen.main.scale, height:size.height * UIScreen.main.scale))
        let context = UIGraphicsGetCurrentContext()
        context!.interpolationQuality = .none
        
        context?.draw(cgImage!, in: CGRect(x: 0.0,y: 0.0,width: context!.boundingBoxOfClipPath.width,height: context!.boundingBoxOfClipPath.height))
        
        let preImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let qrCodeImage = UIImage(cgImage: (preImage?.cgImage!)!, scale: 1.0/UIScreen.main.scale, orientation: .downMirrored)
        
        return qrCodeImage
    }

}

