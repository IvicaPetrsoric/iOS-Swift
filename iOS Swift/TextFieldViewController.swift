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
        
        customView.textFieldData = TextFieldData(type: .text, required: false, title: "Test title", placeholder: "Placeholder", errorTitle: "postoji error")
        customView.setCustomBackgroundColor(.white)
        
//        customView.fra
    }
    
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

    
    var textFieldData: TextFieldData!
    
    private let regularBoderColor = UIColor.black
    private let focusedBorderColor = UIColor.green
    private let errorTitleColor = UIColor.red

    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = textFieldData.placeholder
//        textField.hide
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCustomBackgroundColor(_ color: UIColor) {
//        backgroundColor = color
        
        layer.cornerRadius = 8
        clipsToBounds = true

        layer.borderColor = regularBoderColor.cgColor
        layer.borderWidth = 2
    }
    
    private func setupUI() {
//        addSubview(textField)
//        
//        NSLayoutConstraint.activate([
//        
//        ])
        
//        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
//        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16)
//        textField.heightAnchor.constraint(equalToConstant: 52)
//        textField.centerYAnchor.constraint(equalTo: centerYAnchor)
    }
    

}
