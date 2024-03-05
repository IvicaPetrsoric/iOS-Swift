//
//  TextFieldViewController.swift
//  iOS Swift
//
//  Created by Ivica Petrsoric on 27.01.2024..
//  Copyright © 2024 ivica petrsoric. All rights reserved.
//

import UIKit

class TextFieldViewController: UIViewController {
    
    @IBOutlet weak var customView: CustomTextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .orange
        
//        customView.textFieldData =
//        
//        
//        customView.setCustomBackgroundColor(.white)
        
        customView.setupTextField(
            with: TextFieldData(
                type: .text,
                required: false,
                title: "Test title",
                placeholder: "Placeholder",
                errorTitle: "postoji error"
            )
        )
        
//        customView.fra
    }
    
    
    // regular 80
    // max 101
}

struct TextFieldData {
    enum TextFieldType {
        case password
        case text
    }
    
    let type: TextFieldType
    let required: Bool
    let title: String
    let placeholder: String
    let errorTitle: String?
}

class CustomTextFieldView: UIView {
    
    private let nibName = "CustomTextFieldView"

    
    private func setupContainerView() {
        guard let view = loadViewFromNib(), !contains(view) else { return }
        view.frame = self.bounds
        addSubview(view)
    }

    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupContainerView()
    }

    
    
    // border colors
    private let errorColor = UIColor.red
    
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleRequiredLabel: UILabel!
    @IBOutlet private weak var textFieldContainerView: UIView!
    @IBOutlet private weak var inputTextField: UITextField!
    @IBOutlet private weak var showContentButton: UIButton!
    @IBOutlet private weak var errorLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private var textFieldData: TextFieldData?
    
    func setupTextField(with data: TextFieldData) {
        self.textFieldData = data
        
        inputTextField.isSecureTextEntry = data.type == .password
        showContentButton.isHidden = data.type == .text
        
        
        
        if data.type == .text {
            
        }
        // password type
        else {
            
        }
        
        
        
        textFieldContainerView.layer.cornerRadius = 8
        textFieldContainerView.layer.borderColor = UIColor.textFieldActiveBorderColor.cgColor
        textFieldContainerView.layer.borderWidth = 2
        
        inputTextField.delegate = self
        inputTextField.textColor = .black
        
        let placeholderText = "Enter text here"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray] // Set the color you want
        inputTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        titleLabel.text = "test"
        
    }
    
    func setCustomBackgroundColor(_ color: UIColor) {

    }

    var isShown = false
    
    @IBAction func toggleShowTextFieldContent(_ sender: UIButton) {
        isShown = !isShown
        
        inputTextField.isSecureTextEntry = isShown
        
        let imageName = isShown ? "passwordHide" : "passwordShow"
        sender.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func updateErrorLabel() {
        
    }
    
    func updateTitleLabel() {
        
    }

}


extension UIColor {
    
    static var textFieldActiveBorderColor: UIColor {
        return UIColor(hex: 0x6CD57C)
    }
    
    static var textFieldInactiveBorderColor: UIColor {
        return UIColor(hex: 0xEEEEEF)
    }
    
    
    
    convenience init(hex: Int, alpha: Int = 255) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: CGFloat(alpha) / 255.0)
    }
    
}
 
extension CustomTextFieldView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
